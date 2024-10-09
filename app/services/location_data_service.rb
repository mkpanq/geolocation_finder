class LocationDataService
  def initialize
    @data_provider = DataProvider.new(api_client: ApiClients::IpApi)
  end

  def get_geological_data(query)
    potential_location = find_location_by_query(query)

    potential_location || raise(Errors::NotFoundError)
  end

  def add_geological_data(query, refresh = false)
    potential_location = find_location_by_query(query)

    if potential_location
      raise Errors::DataAlreadyExistsError unless refresh

      data = getData(query)
      potential_location.update!(data)
      return potential_location
    end

    data = getData(query)
    GeoLocation.create!(data)
  end

  def delete_geological_data(query)
    potential_location = find_location_by_query(query)

    potential_location || raise(Errors::NotFoundError)

    potential_location.destroy!
    potential_location
  end

  private

  def find_location_by_query(query)
    GeoLocation.where(query: query).or(GeoLocation.where(domain: query)).or(GeoLocation.where(ip: query)).first
  end

  def getData(query)
    @data_provider.call(query)
  end
end
