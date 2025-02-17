class BlogsController < ApplicationController
  def index
    response = Blog.get_blogs
    @blogs = response["results"]
  end
  def show
    @search_item = params[:search_item]
    response = Blog.search_blogs(@search_item)
    @blogs = response["results"]
  end
end
