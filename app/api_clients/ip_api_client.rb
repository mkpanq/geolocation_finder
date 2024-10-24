class IpApiClient < ApiClient
  API_BASE_URL = "http://ip-api.com/json/"
  API_FIELDS_PARAMS_CODE="1079295"

  # TODO: Could create factory, but rescue errors, are too much depend on Faraday implementaion
  def initialize(http_client = FaradayHttpClient.new(API_BASE_URL, params = {
    "fields" => API_FIELDS_PARAMS_CODE
  }))
    @client = http_client
  end

  def call(query)
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
