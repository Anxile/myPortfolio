class ApiController < ApplicationController
    skip_before_action :ensure_user_logged_in, :verify_authenticity_token
end
