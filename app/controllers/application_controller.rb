class ApplicationController < ActionController::Base
    before_action :ensure_user_logged_in
    helper_method :current_user, :is_loggedin?

    protected
    def ensure_user_logged_in
        redirect_to login_path unless session[:user_id]
    end

    def is_loggedin?
        session[:user_id].present?
    end
    def current_user
        @current_user ||= User.find(session[:user_id])
    end
end
