class LocationDataService
  def initialize
    @data_provider = DataProvider.new(api_client: ApiClients::IpApi)
  end

  def get_geological_data
  end

  def remove_geological_data
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

  private

  def find_location_by_query(query)
    GeoLocation.where(Arel.sql("query LIKE '%#{query}%' OR domain LIKE '%#{query}%' OR ip LIKE '%#{query}%'")).first
  end

  def getData(query)
    @data_provider.call(query)
  end
end
