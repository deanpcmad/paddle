module Paddle
  class Product < Object

    class << self

      def list(params = nil)
        response = Client.get_request("products", params: params)
        Collection.from_response(response, type: Product)
      end

      def create(attrs)
        response = Client.post_request("products", body: attrs)
        Product.new(response.body["data"])
      end

      def retrieve(id)
        response = Client.get_request("products/#{id}")
        Product.new(response.body["data"])
      end

      def update(id, attrs)
        response = Client.patch_request("products/#{id}", body: attrs)
        Product.new(response.body["data"])
      end

    end

  end
end
