module Paddle
  class Error < StandardError
    attr_reader :http_status_code
    attr_reader :paddle_error_code
    attr_reader :paddle_error_message

    def initialize(response_body, http_status_code)
      @response_body = response_body
      @http_status_code = http_status_code
      set_paddle_error_values
      super(build_message)
    end

    private

    def set_paddle_error_values
      @paddle_error_code = @response_body.deep_symbolize_keys.dig(:error, :code)
      @paddle_error_message = @response_body.deep_symbolize_keys.dig(:error, :detail)
    end

    def error_message
      @paddle_error_message || @response_body.dig(:error, :code)
    rescue NoMethodError
      "An unknown error occurred."
    end

    def build_message
      if paddle_error_code.nil?
        return "Error #{@http_status_code}: #{error_message}"
      end
      "Error #{@http_status_code}: #{error_message} '#{paddle_error_code}'"
    end
  end

  class BadRequestError < Error
    private

    def error_message
      "Your request was malformed."
    end
  end

  class AuthenticationMissingError < Error
    private

    def error_message
      "You did not supply valid authentication credentials."
    end
  end

  class ForbiddenError < Error
    private

    def error_message
      "You are not allowed to perform that action."
    end
  end

  class EntityNotFoundError < Error
    private

    def error_message
      "No results were found for your request."
    end
  end

  class ConflictError < Error
    private

    def error_message
      "Your request was a conflict."
    end
  end

  class TooManyRequestsError < Error
    private

    def error_message
      "Your request exceeded the API rate limit."
    end
  end

  class InternalError < Error
    private

    def error_message
      "We were unable to perform the request due to server-side problems."
    end
  end

  class ServiceUnavailableError < Error
    private

    def error_message
      "You have been rate limited for sending more than 20 requests per second."
    end
  end

  class NotImplementedError < Error
    private

    def error_message
      "This resource has not been implemented."
    end
  end


  class ErrorFactory
    HTTP_ERROR_MAP = {
      400 => BadRequestError,
      401 => AuthenticationMissingError,
      403 => ForbiddenError,
      404 => EntityNotFoundError,
      409 => ConflictError,
      429 => TooManyRequestsError,
      500 => InternalError,
      503 => ServiceUnavailableError,
      501 => NotImplementedError
    }.freeze

    def self.create(response_body, http_status_code)
      status = http_status_code
      error_class = HTTP_ERROR_MAP[status] || Error
      error_class.new(response_body, http_status_code) if error_class
    end
  end
end
