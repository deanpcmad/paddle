module Paddle
  class Discount < Object

    class << self

      def list(**params)
        response = Client.get_request("discounts", params: params)
        Collection.from_response(response, type: Discount)
      end

      def create(**params)
        response = Client.post_request("discounts", body: params)
        Discount.new(response.body["data"])
      end

      def retrieve(id:)
        response = Client.get_request("discounts/#{id}")
        Discount.new(response.body["data"])
      end

      def update(id:, **params)
        response = Client.patch_request("discounts/#{id}", body: params)
        Discount.new(response.body["data"])
      end

    end

  end
end
