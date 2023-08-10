module Paddle
  class Price < Object

    class << self

      def list(**params)
        response = Client.get_request("prices", params: params)
        Collection.from_response(response, type: Price)
      end

      def create(**params)
        response = Client.post_request("prices", body: params)
        Price.new(response.body["data"])
      end

      def retrieve(id:)
        response = Client.get_request("prices/#{id}")
        Price.new(response.body["data"])
      end

      def update(id:, **params)
        response = Client.patch_request("prices/#{id}", body: params)
        Price.new(response.body["data"])
      end

    end

  end
end
