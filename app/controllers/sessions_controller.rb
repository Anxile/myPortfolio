class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in, only:[:new, :create]

  def new
  end

  def create
    user_params = params.require(:user).permit(:name, :password, :status)
    user = User.find_by(name: user_params[:name])
    @@user = user
  
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      status(user, user_params[:status])
      redirect_to posts_path, notice: "Logged in!"
    else
      flash.now[:alert] = "Email or password is invalid"
      redirect_to login_path
    end
  end

  def destroy
    Status.find_by(user_id: session[:user_id])&.update(status: "offline")
    reset_session
    @current_user = nil
    redirect_to root_path, notice: "Logged out!"
  end

  def status(user, status)
    if Status.where(user_id: user.id).present?
      Status.where(user_id: user.id).update(status: status)
    else
      Status.create(status: status, user_id: user.id)
    end
  end
end
