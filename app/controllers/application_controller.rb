class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name,:surname,:date,:place, :email, :password ,:avatar) }
            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name,:surname,:date,:place, :email, :password, :current_password , :avatar) }
        end

        rescue_from CanCan::AccessDenied do |exception|
            redirect_to root_path, :alert=> exception.message
       end
       
end
