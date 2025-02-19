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

  def self.search_blogs(item)
    uri = URI("#{BASE_URL}/topstories/v2/#{item}.json?api-key=#{API_KEY}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end
