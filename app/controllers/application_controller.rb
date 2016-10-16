class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :braintree_token

  def braintree_token
    @braintree_token = generate_client_token
  end

  def json_success(status: 200, success: [])
    head status: status and return if success.empty?

    render json: success.to_json, status: status
  end

  def generate_client_token
    if current_user
      if current_user.has_payment_info?
        Braintree::ClientToken.generate(customer_id: current_user.braintree_customer_id)
      else
        Braintree::ClientToken.generate
      end
    end
  end
end
  