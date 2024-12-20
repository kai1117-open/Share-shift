class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_admin!, if: :admin_controller?
  # ユーザーの退会状態を確認
  before_action :check_user_status

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_homes_path
    else
      public_homes_path
    end
  end



  def after_sign_out_path_for(resource)
    about_path
  end


  private

  def check_user_status
    if user_signed_in? && !current_user.status
      sign_out current_user
      redirect_to new_user_session_path, alert: '退会済みのためログインできません。'
    end
  end

  def admin_controller?
    controller_path.start_with?('admin')
  end

  protected

  def configure_permitted_parameters
    # sign_upとaccount_updateで許可するパラメーター
    devise_parameter_sanitizer.permit(:sign_up, keys: [:address, :transportation, :role, :name, :prefecture_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:address, :transportation, :role, :name, :prefecture_id])
  end
end
