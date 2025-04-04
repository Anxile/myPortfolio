class StatusesController < ApplicationController
    def show
        @status = Status.where(user_id: params[:id])
    end
    def create
        @status = Status.create(status: params[:status], user_id: params[:id]) if current_user.present?
    end

end
