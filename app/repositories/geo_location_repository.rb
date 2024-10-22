class GeoLocationRepository
  def create(data)
    GeoLocation.create!(data)
  rescue => e
    raise CustomErrors::ModelValidationError.new("#{__method__}: #{e.message}")
  end

  def update(location, data)
    location.update!(data)
  rescue => e
    raise CustomErrors::ModelValidationError.new("#{__method__}: #{e.message}")
  end

  def delete(location)
    location.destroy!
  rescue => e
    raise CustomErrors::ModelValidationError.new("#{__method__}: #{e.message}")
  end

  def find_location_by_query(query)
    GeoLocation.where(query: query).or(GeoLocation.where(domain: query)).or(GeoLocation.where(ip: query)).first
  end
end
