module Paddle
  class PricesResource < Resource

    def list(params = nil)
      response = get_request("prices", params: params)
      Collection.from_response(response, type: Price)
    end

    def create(attrs)
      response = post_request("prices", body: attrs)
      Price.new(response.body["data"])
    end

    def retrieve(id)
      response = get_request("prices/#{id}")
      Price.new(response.body["data"])
    end

    def update(id, attrs)
      response = patch_request("prices/#{id}", body: attrs)
      Price.new(response.body["data"])
    end

  end
end
