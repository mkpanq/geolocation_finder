class GeoLocationRepository
  def create(data)
    GeoLocation.create!(data)
  end

  def update(location, data)
    location.update!(data)
  end

  def delete(location)
    location.destroy!
  end

  def find_location_by_query(query)
    GeoLocation.where(query: query).or(GeoLocation.where(domain: query)).or(GeoLocation.where(ip: query)).first
  end
end
