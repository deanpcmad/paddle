module Paddle
  class PortalSession < Object
    class << self
      def create(customer:, **params)
        response = Client.post_request("customers/#{customer}/portal-sessions", body: params)
        PortalSession.new(response.body["data"])
      end
    end
  end
end
