class IpApiQueryValidator
  def valid?(query)
    unless RegexMatchers.domain_match(query) || RegexMatchers.ip_match(query)
      raise CustomErrors::QueryValidationError
    end
  end
end
