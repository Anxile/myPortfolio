class Api::V1::UsersController < ApiController
    def index
        @user=User.all
        render json: @user
    end
    def show
        @user=User.find(params[:id])
        render json: @user
    end
    def create
        @user = User.new(user_params)
          if @user.save
            render json: @user
          else
            render json: @user.errors, status: :unprocessable_entity
          end
        end
    end
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :password, :mail)
    end
