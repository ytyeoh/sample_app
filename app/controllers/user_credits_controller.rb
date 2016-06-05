class UserCreditsController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :set_credit, only: [:show, :edit, :update, :destroy]

  def new
    @credit = UserCredit.new
    gon.client_token = generate_client_token
  end

  def create
    @credit = UserCredit.new(credit_params)
    @credit.user_id = current_user.id
    @credit.amount = params[:user_credit][:credits]
    @result = Braintree::Transaction.sale(amount: @credit.amount,payment_method_nonce: params[:payment_method_nonce])
    if @result.success?
      current_user.update(braintree_customer_id: @result.transaction.customer_details.id, credit: @credit.amount) unless current_user.has_payment_info?
      current_user.save
      respond_to do |format|
        if @credit.save
          format.html { redirect_to :back, notice: 'Credit was successfully purchase #{@credit.amount} credits.' }
          format.json { render :show, status: :created, location: @credit }
        else
          format.html { render :new }
          format.json { render json: @credit.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
      gon.client_token = generate_client_token
      redirect_to :back
    end
  end

  def index
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit
      @credit = UserCredit.find(params[:id])
    end

    def generate_client_token
      if current_user.has_payment_info?
        Braintree::ClientToken.generate(customer_id: current_user.braintree_customer_id)
      else
        Braintree::ClientToken.generate
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def credit_params
      params.require(:user_credit).permit(:user_id, :credits, :amount)
    end
end
