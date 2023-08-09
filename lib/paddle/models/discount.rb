module Paddle
  class Discount < Object

    class << self

      def list(params = nil)
        response = Client.get_request("discounts", params: params)
        Collection.from_response(response, type: Discount)
      end

      def create(attrs)
        response = Client.post_request("discounts", body: attrs)
        Discount.new(response.body["data"])
      end

      def retrieve(id)
        response = Client.get_request("discounts/#{id}")
        Discount.new(response.body["data"])
      end

      def update(id, attrs)
        response = Client.patch_request("discounts/#{id}", body: attrs)
        Discount.new(response.body["data"])
      end

    end

  end
end
