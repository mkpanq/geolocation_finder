class FaradayHttpClient < HttpClient
  def initialize(base_url, params = {})
    @client = Faraday.new(url: base_url) do |faraday|
                faraday.response :json
                faraday.response :raise_error
                faraday.response :logger

                faraday.params = params
              end
  end

  def get(query)
    @client.get(query)
  end
end
