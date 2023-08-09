module Paddle
  class Price < Object

    class << self

      def list(params = nil)
        response = Client.get_request("prices", params: params)
        Collection.from_response(response, type: Price)
      end

      def create(attrs)
        response = Client.post_request("prices", body: attrs)
        Price.new(response.body["data"])
      end

      def retrieve(id)
        response = Client.get_request("prices/#{id}")
        Price.new(response.body["data"])
      end

      def update(id, attrs)
        response = Client.patch_request("prices/#{id}", body: attrs)
        Price.new(response.body["data"])
      end

    end

  end
end
