module Paddle
  class Client
    BASE_URL = "https://vendors.paddle.com/api/2.0"
    SANDBOX_BASE_URL = "https://sandbox-vendors.paddle.com/api/2.0"

    attr_reader :vendor_id, :vendor_auth_code, :sandbox, :adapter

    def initialize(vendor_id:, vendor_auth_code:, sandbox: false, adapter: Faraday.default_adapter, stubs: nil)
      @vendor_id = vendor_id
      @vendor_auth_code = vendor_auth_code
      @sandbox = sandbox
      @adapter = adapter

      # Test stubs for requests
      @stubs = stubs
    end

    def plans
      PlansResource.new(self)
    end

    def connection
      url = (sandbox == true ? SANDBOX_BASE_URL : BASE_URL)
      @connection ||= Faraday.new(url) do |conn|
        conn.request :json

        conn.response :dates
        conn.response :json, content_type: "application/json"

        conn.adapter adapter, @stubs
      end
    end
  end
end
