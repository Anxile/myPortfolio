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
        resume = s3_resource.bucket('subscriptionmailer').object('Resume.png')
        transcript1 = s3_resource.bucket('subscriptionmailer').object('Transcript_Page_1.png')
        transcript2 = s3_resource.bucket('subscriptionmailer').object('Transcript_Page_2.png')
        test = s3_resource.bucket('subscriptionmailer').object('You Got this!.png')
        @signed_url_resume = resume.presigned_url(:get, expires_in: 86400)
        @signed_url_transcript1 = transcript1.presigned_url(:get, expires_in: 86400)
        @signed_url_transcript2 = transcript2.presigned_url(:get, expires_in: 86400)
        @signed_url_test = test.presigned_url(:get, expires_in: 86400)
        return @signed_url_resume, @signed_url_transcript1, @signed_url_transcript2, @signed_url_test
      end
end
