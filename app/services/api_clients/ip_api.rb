module ApiClients
  class IpApi
    DOMAIN_REGEX = /^((?!-)[A-Za-z0-9-]{1,63}(?<!-)\.)+[A-Za-z]{2,}$/
    IP_REGEX = /^(((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])|(([0-9a-fA-F]{1,4}):){7}([0-9a-fA-F]{1,4}))$/

    def self.call(query)
      validate_query(query)
    end
  end

  private

  def validate_query(query)
    unless query.match?(DOMAIN_REGEX) || query.match?(IP_REGEX)
      raise ArgumentError, "Invalid query format. Must be a domain or an IP (IPv4 / IPv6) address."
    end
  end
end
