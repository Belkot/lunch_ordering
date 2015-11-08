class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u|
        u.permit(
                 :name,
                 :email,
                 :password,
                 :password_confirmation,
                 :remember_me,
                 :avatar,
                 :avatar_cache
                )
      }
      devise_parameter_sanitizer.for(:account_update) { |u|
        u.permit(
                 :name,
                 :email,
                 :password,
                 :password_confirmation,
                 :current_password,
                 :avatar,
                 :avatar_cache
                )
      }
    end

    def ensure_admin!
      unless current_user.admin?
        sign_out current_user

        redirect_to root_path, error: 'Access denied, you must be admin!'

        return false
      end
  end

end
