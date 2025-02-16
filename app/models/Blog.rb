require 'net/http'
require 'uri'
require 'json'

class Blog
  BASE_URL = "https://api.nytimes.com/svc"
  API_KEY = "qhCbpqi9dh0kl7SvvuuoEz5jV6I7DoGN"

  def self.get_blogs
    uri = URI("#{BASE_URL}/topstories/v2/world.json?api-key=#{API_KEY}")
    
    response = Net::HTTP.get(uri) # 发送 GET 请求
    JSON.parse(response) # 解析 JSON 响应
  end
end
