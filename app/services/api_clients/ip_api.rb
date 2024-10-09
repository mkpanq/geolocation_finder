module ApiClients
  class IpApi
    API_BASE_URL = "http://ip-api.com/json/"
    API_FIELDS_PARAMS_CODE="1079295"

    def self.call(query)
      client = IpApi.generateFaradayClient

      begin
        response = client.get(query)
        data = response.body
        raise Errors::NotFoundError if data["status"] == "fail"

        IpApi.serializer(query, data)
      rescue Faraday::TooManyRequestsError
        raise Errors::TooManyRequestsError
      rescue Faraday::Error
        raise Errors::ServerError
      end
    end

    def self.generateFaradayClient
      Faraday.new(url: API_BASE_URL) do |faraday|
        faraday.response :json
        faraday.response :raise_error
        faraday.response :logger

        faraday.params["fields"]=API_FIELDS_PARAMS_CODE
      end
    end

    def self.serializer(query, data)
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
end
