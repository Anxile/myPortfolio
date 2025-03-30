class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in, only:[:new, :create]

  def new
  end

  def create
    user = User.find_by(name: params[:user][:name])
    password = params[:user][:password]
    puts password, user
    if user && user.authenticate(password)
      session[:user_id] = user.id
      redirect_to users_path, notice: "Logged in!"
    else
      flash.now[:alert] = "Email or password is invalid"
      redirect_to login_path
    end
  end

  def destroy
    reset_session
    @current_user = nil
    redirect_to root_path, notice: "Logged out!"
  end
end
