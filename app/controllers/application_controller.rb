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
    def s3_client
        s3_resource = Aws::S3::Resource.new(
        region: Rails.application.credentials.dig(:aws, :region),
        access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
        secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key)
        )
        object = s3_resource.bucket('subscriptionmailer').object('You Got this!.png')
        @signed_url = object.presigned_url(:get, expires_in: 300)
      end
end
