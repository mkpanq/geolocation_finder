module ApiClients
  class IpApi
    DOMAIN_REGEX = /^((?!-)[A-Za-z0-9-]{1,63}(?<!-)\.)+[A-Za-z]{2,}$/
    IP_REGEX = /^(((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])|(([0-9a-fA-F]{1,4}):){7}([0-9a-fA-F]{1,4}))$/

    API_BASE_URL = "http://ip-api.com/json/"
    API_FIELDS_PARAMS_CODE="1079295"

    def self.call(query)
      IpApi.query_validator(query)
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

    def self.query_validator(query)
      unless query.match?(DOMAIN_REGEX) || query.match?(IP_REGEX)
        raise Errors::QueryValidationError
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
