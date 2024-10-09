class DataProvider
  attr_reader :api_client

  def initialize(api_client:)
    @api_client = api_client
  end

  def call(query)
    query_validator(query)

    @api_client.call(query)
  end

  private

  def query_validator(query)
    unless RegexMatchers.domain_match(query) || RegexMatchers.ip_match(query)
      raise CustomErrors::QueryValidationError
    end
  end
end
