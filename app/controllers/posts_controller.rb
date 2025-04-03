class PostsController < ApplicationController
    def index
        @posts = Post.all
    end

    def show
        @post = Post.find_by(params[:id])
    end

    def new
        @post = Post.new
    end
    def create
        @post = Post.create(title: params[:post][:title], content: params[:post][:content], user_id: current_user.id)
    end

    def upload_image
    end
end
