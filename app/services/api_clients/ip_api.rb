module ApiClients
  class IpApi
    DOMAIN_REGEX = /^((?!-)[A-Za-z0-9-]{1,63}(?<!-)\.)+[A-Za-z]{2,}$/
    IP_REGEX = /^(((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])|(([0-9a-fA-F]{1,4}):){7}([0-9a-fA-F]{1,4}))$/

    API_BASE_URL = "http://ip-api.com/json/"

    def self.call(query)
      unless query.match?(DOMAIN_REGEX) || query.match?(IP_REGEX)
        raise Errors::QueryValidationError
      end

      client = Faraday.new(url: API_BASE_URL) do |faraday|
        faraday.response :json
        faraday.response :raise_error
      end

      begin
        response = client.get(query)
        data = response.body
        raise Errors::NotFoundError if data["status"] == "fail"

        data
      rescue Faraday::TooManyRequestsError
        raise Errors::TooManyRequestsError
      rescue Faraday::Error
        raise Errors::ServerError
      end
    end
  end
end
