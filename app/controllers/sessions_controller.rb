class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:user][:name])
    password = params[:user][:password]
    puts password, user
    if user && user.authenticate(password)
      redirect_to users_path, notice: "Logged in!"
    else
      flash.now[:alert] = "Email or password is invalid"
      redirect_to login_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Logged out!"
  end
end
