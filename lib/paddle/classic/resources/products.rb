module Paddle
  module Classic
    class ProductsResource < Resource

      def list
        response = post_request("2.0/product/get_products")
        Collection.from_response(response, type: Product, key: "products")
      end

    end
  end
end
