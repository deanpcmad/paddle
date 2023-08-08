module Paddle
  class Client

    BASE_URL = "https://api.paddle.com"
    SANDBOX_BASE_URL = "https://sandbox-api.paddle.com"

    attr_reader :api_key, :sandbox, :adapter

    def initialize(api_key:, sandbox: false, adapter: Faraday.default_adapter, stubs: nil)
      @api_key = api_key
      @sandbox = sandbox
      @adapter = adapter

      # Test stubs for requests
      @stubs = stubs
    end

    def url
      if sandbox == true
        SANDBOX_BASE_URL
      else
        BASE_URL
      end
    end

    def connection
      url = (sandbox == true ? SANDBOX_BASE_URL : BASE_URL)
      @connection ||= Faraday.new(url) do |conn|
        conn.request :authorization, :Bearer, api_key

        conn.headers = {
          "User-Agent" => "paddlerb/v#{VERSION} (github.com/deanpcmad/paddlerb)"
        }

        conn.request :json

        conn.response :json, content_type: "application/json"

        conn.adapter adapter, @stubs
      end
    end

  end
end
