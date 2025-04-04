class CommentsController < ApplicationController
    def create
        @post = Post.find_by(id: params[:post_id])
        @comment = Comment.new(content: params[:comment][:content], post_id: @post.id, has_modified:false, user_id: current_user.id)
        if @comment.save
            redirect_to @post
        else
            render 'posts/show'
        end
    end
end
