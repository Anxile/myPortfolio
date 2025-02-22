class BlogsController < ApplicationController
  before_action :set_available_keywords

  def index
    if params[:category].present?
      response = Blog.search_blogs(params[:category])
    else
      response = Blog.get_blogs
    end
    @blogs = response["results"]
  end

  def show
    # 使用 RESTful 方式，params[:id] 为 URL 中的动态参数
    @blog = Blog.show_detail(params[:category] = 'world',params[:id])
    if @blog.nil?
      flash[:alert] = "Article not found."
      redirect_to blogs_path
    end
  end

  private

  def set_available_keywords
    @available_keyword = ['arts', 'automobiles', 'books/review', 'business', 'fashion', 'food', 'health', 'home', 'insider', 'magazine', 'movies', 'nyregion', 'obituaries', 'politics', 'realestate', 'science', 'sports', 'sundayreview', 'technology', 'theater', 'travel', 'upshot', 'us', 'world']
  end

end
