class IpApiClient < ApiClient
  API_BASE_URL = "http://ip-api.com/json/"
  API_FIELDS_PARAMS_CODE="1079295"

  def initialize
    @client = generateFaradayClient(API_BASE_URL)
  end

  def call(query)
    @client.params["fields"]=API_FIELDS_PARAMS_CODE

    begin
      response = @client.get(query)
      data = response.body
      raise CustomErrors::NotFoundError if data["status"] == "fail"

      data
    rescue Faraday::TooManyRequestsError
      raise CustomErrors::TooManyRequestsError
    rescue Faraday::Error
      raise CustomErrors::ServerError
    end
  end
end
