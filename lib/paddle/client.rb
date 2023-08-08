module Paddle
  class Client

    BASE_URL = "https://api.paddle.com"
    SANDBOX_BASE_URL = "https://sandbox-api.paddle.com"

    CLASSIC_BASE_URL = "https://vendors.paddle.com/api"
    SANDBOX_CLASSIC_BASE_URL = "https://sandbox-vendors.paddle.com/api"

    attr_reader :vendor_id, :vendor_auth_code, :sandbox, :adapter

    def initialize(vendor_id:, vendor_auth_code:, classic: false, sandbox: false, adapter: Faraday.default_adapter, stubs: nil)
      @vendor_id = vendor_id
      @vendor_auth_code = vendor_auth_code
      @classic = classic
      @sandbox = sandbox
      @adapter = adapter

      # Test stubs for requests
      @stubs = stubs
    end

    def classic?
      @classic == true
    end
    def sandbox?
      @sandbox == true
    end

    def plans
      if classic?
        Classic::PlansResource.new(self)
      end
    end

    def coupons
      if classic?
        Classic::CouponsResource.new(self)
      end
    end

    def products
      if classic?
        Classic::ProductsResource.new(self)
      end
    end

    def licenses
      if classic?
        Classic::LicensesResource.new(self)
      end
    end

    def pay_links
      if classic?
        Classic::PayLinksResource.new(self)
      end
    end

    def transactions
      if classic?
        Classic::TransactionsResource.new(self)
      end
    end

    def payments
      if classic?
        Classic::PaymentsResource.new(self)
      end
    end

    def users
      if classic?
        Classic::UsersResource.new(self)
      end
    end

    def webhooks
      if classic?
        Classic::WebhooksResource.new(self)
      end
    end

    def modifiers
      if classic?
        Classic::ModifiersResource.new(self)
      end
    end

    def charges
      if classic?
        Classic::ChargesResource.new(self)
      end
    end

    def url
      if classic?
        if sandbox?
          SANDBOX_CLASSIC_BASE_URL
        else
          CLASSIC_BASE_URL
        end
      else
        if sandbox?
          SANDBOX_BASE_URL
        else
          BASE_URL
        end
      end
    end

    def connection
      @connection ||= Faraday.new(url) do |conn|
        conn.request :json

        conn.response :json, content_type: "application/json"

        conn.adapter adapter, @stubs
      end
    end
  end
end
