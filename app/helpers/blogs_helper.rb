module BlogsHelper
  def generate_id(title)
    Digest::MD5.hexdigest(title)
  end

  def find_article(articles, title)
    articles.find { |article| generate_id(article["title"]) == title }
  end
end
