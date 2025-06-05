class HomeController < ApplicationController
  skip_before_action :ensure_user_logged_in
  def index
    @signed_url = s3_client
  end
  require 'ostruct'

  def subscribe
    email = params[:email]
    respond_to do |format|
      if email.present?
        user = OpenStruct.new(email: email)
        @signed_url = s3_client
        SubscriptionMailer.subscribe(user, @signed_url).deliver_now
        format.html { redirect_to root_path, notice: 'Resume sent successfully.' }
        format.json { head :no_content }
      else
        format.html { redirect_to root_path, alert: 'Please provide an email.' }
        format.json { head :unprocessable_entity }
      end
    end
  end
end
