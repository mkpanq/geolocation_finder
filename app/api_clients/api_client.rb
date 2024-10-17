class ApiClient
  def call(*args)
    raise NotImplementedError
  end

  protected

  def generateFaradayClient(url)
    Faraday.new(url: url) do |faraday|
      faraday.response :json
      faraday.response :raise_error
      faraday.response :logger
    end
  end
end
