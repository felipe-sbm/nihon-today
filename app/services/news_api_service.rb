require "net/http"
require "json"

class NewsApiService
  BASE_URL = "https://newsapi.org/v2/everything"

  def self.fetch_news(query = "Japan")
    api_key = Rails.application.credentials.dig(:newsapi, :api_key)
    url = URI("#{BASE_URL}?q=#{query}&language=ja&sortBy=popularity&apiKey=#{api_key}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    JSON.parse(response.body)
  rescue StandardError => e
    Rails.logger.error("Error (finding news): #{e.message}")
    { "articles" => [] }
  end
end
