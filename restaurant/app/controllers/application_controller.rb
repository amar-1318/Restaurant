class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery unless: -> { request.format.json? }

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:address, :gender, :city_id, :role, :name, :email, :password, :contact])
  end

  def after_sign_in_path_for(resource)
    case resource.role
    when "CUSTOMER"
      customer_dashboard_users_path
    when "OWNER"
      owner_dashboard_users_path
    else
      admin_admins_path
    end
  end
end
