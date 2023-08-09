module Paddle
  class CustomersResource < Resource

    def list(params = nil)
      response = get_request("customers", params: params)
      Collection.from_response(response, type: Customer)
    end

    def create(attrs)
      response = post_request("customers", body: attrs)
      Customer.new(response.body["data"])
    end

    def retrieve(id)
      response = get_request("customers/#{id}")
      Customer.new(response.body["data"])
    end

    def update(id, attrs)
      response = patch_request("customers/#{id}", body: attrs)
      Customer.new(response.body["data"])
    end

  end
end
