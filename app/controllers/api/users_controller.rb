class Api::UsersController < ApiController
    def index
        @user=User.all
        render json: @user
    end
end