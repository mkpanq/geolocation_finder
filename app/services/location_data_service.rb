class LocationDataService
  def initialize
    @data_provider = DataProvider.new(api_client: ApiClients::IpApi)
  end
end
