class DataServiceFactory
  def self.create_ip_location_data_service
    IpLocationDataService.new(
      repository = GeoLocationRepository.new,
      data_provider = IpApiClient.new,
      query_validator = IpApiQueryValidator.new,
      data_serializer = IpApiDataSerializer.new
    )
  end
end
