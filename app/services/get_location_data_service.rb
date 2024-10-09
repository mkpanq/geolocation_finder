class GetLocationDataService
  attr_reader :api_client

  def initialize(api_client:)
    @api_client = api_client
  end

  def call(query)
    @api_client.call(query)
  end
end
