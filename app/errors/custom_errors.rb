module CustomErrors
  class QueryValidationError < StandardError
    attr_reader :status

    def initialize
      super("Invalid query format. Must be a domain or an IP (IPv4 / IPv6) address.")
      @status = :bad_request
    end
  end

  class ModelValidationError < StandardError
    attr_reader :status

    def initialize(log)
      super("Can't save object to the database: " + log)
      @status = :unprocessable_entity
    end
  end

  class DataAlreadyExistsError < StandardError
    attr_reader :status

    def initialize
      super("Data already exists. Use 'refresh' parameter to update.")
      @status = :unprocessable_entity
    end
  end

  class TooManyRequestsError < StandardError
    attr_reader :status

    def initialize
      super("Too many requests. Please try again later.")
      @status = :too_many_requests
    end
  end

  class ServerError < StandardError
    attr_reader :status

    def initialize
      super("Failed to fetch data. Please try again later.")
      @status = :internal_server_error
    end
  end

  class NotFoundError < StandardError
    attr_reader :status

    def initialize
      super("Could not find location for given query.")
      @status = :not_found
    end
  end
end
