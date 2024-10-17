class IpApiDataSerializer
  def serialize(query, data)
    {
      "query": query,
      "ip": data["query"],
      "domain": data["reverse"],
      "continent": data["continent"],
      "country": data["country"],
      "country_code": data["countryCode"],
      "region": data["regionName"],
      "region_code": data["region"],
      "city": data["city"],
      "zip": data["zip"],
      "timezone": data["timezone"],
      "lattitude": data["lat"],
      "longitude": data["lon"],
      "isp_name": data["isp"],
      "org_name": data["org"]
    }
  end
end
