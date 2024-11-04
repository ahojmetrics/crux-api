require "httparty"

class CruxApi::Client
  # frozen_string_literal: true

  API_URL = "https://chromeuxreport.googleapis.com/v1/records"

  def initialize
    @api_key = ENV.fetch("GOOGLE_API_KEY", nil)
  end

  def get(url)
    return {error: "No API key found"} unless @api_key

    Rails.cache.fetch("#{cache_key(api_type: "rolling", url: url)}", expires_in: 12.hours) do
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

    Rails.cache.fetch("#{cache_key(api_type: "history", url: url)}", expires_in: 12.hours) do
      puts "Uncached: Fetching from API"

      response = HTTParty.post(
        "#{API_URL}:queryHistoryRecord?key=#{@api_key}",
        query: {
          url: url,
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
    url = url.gsub("https://", "").gsub("http://", "")
    "crux_#{api_type}_api_#{url}"
  end
end
