module Api
    module V1
      class RegistrationsController < Devise::RegistrationsController
        skip_before_action :ensure_user_logged_in, :verify_authenticity_token
        respond_to :json
  
        def create
          build_resource(sign_up_params)
  
          if resource.save
            render json: {
              status: { code: 200, message: 'Signed up successfully.' },
              data: resource.as_json(only: [:id, :email, :created_at])
            }, status: :ok
          else
            render json: {
              status: { code: 422, message: "User couldn't be created successfully.", errors: resource.errors.full_messages }
            }, status: :unprocessable_entity
          end
        rescue StandardError => e
          render json: {
            status: { code: 500, message: 'Internal Server Error', error: e.message }
          }, status: :internal_server_error
        end
  
        private
  
        def sign_up_params
          params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end
      end
    end
  end