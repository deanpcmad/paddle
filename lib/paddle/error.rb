module Paddle
  class Error < StandardError
    attr_reader :response

    def initialize(response_body, status_code)
      @response = response_body
      @status_code = status_code
      super(build_message)
    end

    private

    def error_message
      @response.dig("error", "detail") || @response.dig("error", "code")
    rescue NoMethodError
      "An unknown error occurred."
    end

    def paddle_error_code
      @response.deep_symbolize_keys.dig(:error, :code) || nil
    end

    def build_message
      if paddle_error_code.nil?
        return "Error #{@status_code}: #{error_message}"
      end
      "Error #{@status_code}: #{error_message} '#{paddle_error_code}'"
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
      "Error 403: You are not allowed to perform that action."
    end
  end

  class EntityNotFoundError < Error
    private

    def error_message
      "Error 404: No results were found for your request."
    end
  end

  class ConflictError < Error
    private

    def error_message
      "Error 409: Your request was a conflict."
    end
  end

  class TooManyRequestsError < Error
    private

    def error_message
      "Error 429: Your request exceeded the API rate limit."
    end
  end

  class InternalError < Error
    private

    def error_message
      "Error 500: We were unable to perform the request due to server-side problems."
    end
  end

  class ServiceUnavailableError < Error
    private

    def error_message
      "Error 503: You have been rate limited for sending more than 20 requests per second."
    end
  end

  class NotImplementedError < Error
    private

    def error_message
      "Error 501: This resource has not been implemented."
    end
  end

  class CustomerAlreadyExistsError < Error
    private

    def error_message
      "#{@response.dig(:error, :detail)}"
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

    PADDLE_ERROR_MAP = {
      "customer_already_exists" => CustomerAlreadyExistsError
    }.freeze

    def self.create(response_body, status_code)
      status = status_code
      error_code = response_body.dig(:error, :code) || nil
      error_class = PADDLE_ERROR_MAP[error_code] || HTTP_ERROR_MAP[status]
      error_class.new(response_body, status_code) if error_class
    end
  end
end
