require "httparty"

class CruxApi::Client
  # frozen_string_literal: true

  API_URL = "https://chromeuxreport.googleapis.com/v1/records"

  def initialize
    @api_key = ENV.fetch("GOOGLE_API_KEY", nil)
  end

  def get(url)
    return {error: "No API key found"} unless @api_key

    Rails.cache.fetch(cache_key(api_type: "rolling", url: url).to_s, expires_in: 12.hours) do
      puts "Uncached: Fetching from API"

      response = HTTParty.post(
        "#{API_URL}:queryRecord?key=#{@api_key}",
        query: {
          url: url
        }
      )

      response.parsed_response
    end
  end

  def history(url)
    return {error: "No API key found"} unless @api_key

    Rails.cache.fetch(cache_key(api_type: "history", url: url).to_s, expires_in: 12.hours) do
      puts "Uncached: Fetching from API"

      response = HTTParty.post(
        "#{API_URL}:queryHistoryRecord?key=#{@api_key}",
        query: {
          origin: url,
          formFactor: "PHONE"
        },
        headers: {
          "Content-Type" => "application/json",
          "Accept" => "application/json"
        }
      )

      response.parsed_response
    end
  end

  private

  def cache_key(api_type:, url:)
    url = url.gsub("https://", "https_").gsub("http://", "http_")
    "crux_#{api_type}_api_#{url}"
  end
end
