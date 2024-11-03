require "httparty"

class CruxApi::Client
  # frozen_string_literal: true
 
  API_URL = "https://chromeuxreport.googleapis.com/v1/records"

  def initialize
    @api_key = ENV.fetch("GOOGLE_API_KEY", nil)
  end

  def get(url)
    return { error: "No API key found" } unless @api_key

    response = HTTParty.post(
      "#{API_URL}:queryRecord?key=#{@api_key}",
      query: {
        url: url
      }
    )

    response.parsed_response
  end

  def history(url)
    return { error: "No API key found" } unless @api_key

    response = HTTParty.post(
      "#{API_URL}:queryHistoryRecord?key=#{@api_key}",
      query: {
        url: url,
        formFactor: "PHONE",
      },
      headers: {
        "Content-Type" => "application/json",
        "Accept" => "application/json",
      }
    )
    
    response.parsed_response
  end
end
