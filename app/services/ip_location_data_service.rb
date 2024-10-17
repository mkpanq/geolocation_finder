class IpLocationDataService < DataService
  def initialize(
    repository,
    data_provider,
    query_validator,
    data_serializer
  )
    @repository = repository
    @data_provider = data_provider
    @query_validator = query_validator
    @data_serializer = data_serializer
  end

  def get_geological_data(query)
    potential_location = @repository.find_location_by_query(query)
    potential_location || raise(CustomErrors::NotFoundError)
  end

  def add_geological_data(query, refresh = false)
    @query_validator.valid?(query)
    potential_location = @repository.find_location_by_query(query)
    if potential_location
      raise CustomErrors::DataAlreadyExistsError unless refresh

      data = @data_provider.call(query)
      serialized_data = @data_serializer.serialize(query, data)
      @repository.update(potential_location, serialized_data)

      return potential_location
    end

    data = @data_provider.call(query)
    serialized_data = @data_serializer.serialize(query, data)
    @repository.create(serialized_data)
  end

  def delete_geological_data(query)
    potential_location = @repository.find_location_by_query(query)
    potential_location || raise(CustomErrors::NotFoundError)

    @repository.delete(potential_location)
  end
end
