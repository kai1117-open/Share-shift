class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?



  def after_sign_in_path_for(resource)
    public_posts_path
  end

  def after_sign_out_path_for(resource)
    about_path
  end



  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:address, :transportation, :role, :name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:address, :transportation, :role, :name])
  end
end
