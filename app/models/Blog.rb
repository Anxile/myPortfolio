require 'net/http'
require 'uri'
require 'json'

class Blog
  BASE_URL = "https://api.nytimes.com/svc"
  API_KEY = "qhCbpqi9dh0kl7SvvuuoEz5jV6I7DoGN"

  def self.get_blogs
    uri = URI("#{BASE_URL}/topstories/v2/world.json?api-key=#{API_KEY}")
    
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def self.search_blogs(category="world")
    uri = URI("#{BASE_URL}/topstories/v2/#{category}.json?api-key=#{API_KEY}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def self.show_detail(category, id)
    # 这里我们重新调用 get_blogs（实际情况中你可能有专门的详情 API）
    response = search_blogs(category)
    blogs = response["results"]
    # 根据生成的 ID 匹配文章。假设 ID 是通过文章标题生成的 MD5 哈希
    blogs.find { |blog| self.generate_id(blog["title"]) == id }
  end

  def self.generate_id(title)
    Digest::MD5.hexdigest(title)
  end
end
