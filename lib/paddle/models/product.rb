module Paddle
  class Product < Object

    class << self

      def list(**params)
        response = Client.get_request("products", params: params)
        Collection.from_response(response, type: Product)
      end

      def create(**params)
        response = Client.post_request("products", body: params)
        Product.new(response.body["data"])
      end

      def retrieve(id:)
        response = Client.get_request("products/#{id}")
        Product.new(response.body["data"])
      end

      def update(id:, **params)
        response = Client.patch_request("products/#{id}", body: params)
        Product.new(response.body["data"])
      end

    end

  end
end
