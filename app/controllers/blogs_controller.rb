class BlogsController < ApplicationController
  before_action :set_available_keywords

  def index
    response = Blog.get_blogs
    @blogs = response["results"]
  end

  def show
    @search_item = params[:id]
    response = Blog.search_blogs(@search_item)
    @blogs = response["results"]
  end

  private

  def set_available_keywords
    @available_keyword = ['arts', 'automobiles', 'books/review', 'business', 'fashion', 'food', 'health', 'home', 'insider', 'magazine', 'movies', 'nyregion', 'obituaries', 'politics', 'realestate', 'science', 'sports', 'sundayreview', 'technology', 'theater', 'travel', 'upshot', 'us', 'world']
  end
end
