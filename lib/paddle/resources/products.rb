module Paddle
  class ProductsResource < Resource

    def list(params = nil)
      response = get_request("products", params: params)
      Collection.from_response(response, type: Product)
    end

    def create(attrs)
      response = post_request("products", body: attrs)
      Product.new(response.body["data"])
    end

    def retrieve(id)
      response = get_request("products/#{id}")
      Product.new(response.body["data"])
    end

    def update(id, attrs)
      response = patch_request("products/#{id}", body: attrs)
      Product.new(response.body["data"])
    end

  end
end
