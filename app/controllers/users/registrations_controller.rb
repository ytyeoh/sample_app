class Users::RegistrationsController < Devise::RegistrationsController

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
  
  private

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :identity_card, :stage, :image, :password, :password_confirmation, :contact)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :identity_card, :stage, :image, :password, :password_confirmation, :current_password)
  end
end