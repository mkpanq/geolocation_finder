module Errors
  class QueryValidationError < StandardError
    def initialize
      super("Invalid query format. Must be a domain or an IP (IPv4 / IPv6) address.")
    end
  end

  class TooManyRequestsError < StandardError
    def initialize
      super("Too many requests. Please try again later.")
    end
  end

  class ServerError < StandardError
    def initialize
      super("Failed to fetch data. Please try again later.")
    end
  end

  class NotFoundError < StandardError
    def initialize
      super("Could not find location for given query.")
    end
  end
end
