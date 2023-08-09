module Paddle
  class DiscountsResource < Resource

    def list(params = nil)
      response = get_request("discounts", params: params)
      Collection.from_response(response, type: Discount)
    end

    def create(attrs)
      response = post_request("discounts", body: attrs)
      Discount.new(response.body["data"])
    end

    def retrieve(id)
      response = get_request("discounts/#{id}")
      Discount.new(response.body["data"])
    end

    def update(id, attrs)
      response = patch_request("discounts/#{id}", body: attrs)
      Discount.new(response.body["data"])
    end

  end
end
