require 'net/http'
require 'uri'
require 'json'

class Blog
  BASE_URL = "https://api.nytimes.com/svc"
  API_KEY = "qhCbpqi9dh0kl7SvvuuoEz5jV6I7DoGN"

  def self.get_blogs(category = "world")
    uri = URI("#{BASE_URL}/topstories/v2/#{category}.json?api-key=#{API_KEY}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def self.show_detail(category, id)
    response = get_blogs(category)
    blogs = response["results"]
    blogs.find { |blog| generate_id(blog["title"]) == id }
  end
  def self.generate_id(title)
    Digest::MD5.hexdigest(title)
  end
end
