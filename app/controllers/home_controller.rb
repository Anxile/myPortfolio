class HomeController < ApplicationController
  skip_before_action :ensure_user_logged_in
  def index
    @signed_url = s3_client
  end
  def subscribe
    @user = current_user
    if current_user
      @signed_url = s3_client
      SubscriptionMailer.subscribe(@user, @signed_url).deliver_now
    end

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'succeed' }
      format.json { head :no_content }
    end
  end
end
