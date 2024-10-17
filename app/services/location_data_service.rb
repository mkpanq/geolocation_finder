# TODO: Refactor
class LocationDataService
  def initialize
    @repository = GeoLocationRepository.new
    @data_provider = IpApiClient.new
    @query_validator = IpApiQueryValidator.new
    @data_serializer = IpApiDataSerializer.new
  end

  def get_geological_data(query)
    potential_location = @repository.find_location_by_query(query)
    potential_location || raise(CustomErrors::NotFoundError)
  end

  def add_geological_data(query, refresh = false)
    potential_location = @repository.find_location_by_query(query)

    if potential_location
      raise CustomErrors::DataAlreadyExistsError unless refresh

      data = @data_provider.call(query)
      @repository.update(potential_location, data)

      return potential_location
    end

    data = @data_provider.call(query)
    @repository.create(data)
  end

  def delete_geological_data(query)
    potential_location = @repository.find_location_by_query(query)
    potential_location || raise(CustomErrors::NotFoundError)

    @repository.delete(potential_location)
  end
end
