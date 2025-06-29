class HomeController < ApplicationController
  skip_before_action :ensure_user_logged_in
  def index
    @signed_url_resume, @signed_url_transcript1, @signed_url_transcript2, @signed_url_test = s3_client
  end
  require 'ostruct'

  def subscribe
    email = params[:email]
    HrEmail.create(email: email, user_agent: request.user_agent, ip_address: request.remote_ip) if email.present? && HrEmail.where(email: email).empty?
    respond_to do |format|
      if email.present?
        user = OpenStruct.new(email: email)
        @signed_url_resume, @signed_url_transcript1, @signed_url_transcript2, @signed_url_test = s3_client
        SubscriptionMailer.subscribe(user, @signed_url_resume, @signed_url_transcript1, @signed_url_transcript2, @signed_url_test).deliver_now
        format.html { redirect_to root_path, notice: 'Resume sent successfully.' }
        format.json { head :no_content }
      else
        format.html { redirect_to root_path, alert: 'Please provide an email.' }
        format.json { head :unprocessable_entity }
      end
    end
  end
end
