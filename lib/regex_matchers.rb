module RegexMatchers
  DOMAIN_REGEX = /^((?!-)[A-Za-z0-9-]{1,63}(?<!-)\.)+[A-Za-z]{2,}$/
  IP_REGEX = /^(((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])|(([0-9a-fA-F]{1,4}):){7}([0-9a-fA-F]{1,4}))$/

  def self.domain_match(query)
    query.match?(DOMAIN_REGEX)
  end

  def self.ip_match(query)
    query.match?(IP_REGEX)
  end
end
