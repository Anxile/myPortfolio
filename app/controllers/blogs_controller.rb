class BlogsController < ApplicationController
  def index
    response = Blog.get_blogs
    @blogs = response["results"]
  end
  def show
  end
end
