module Paddle
  class AddressesResource < Resource

    def list(customer, params = nil)
      response = get_request("customers/#{customer}/addresses", params: params)
      Collection.from_response(response, type: Address)
    end

    def create(customer, attrs)
      response = post_request("customers/#{customer}/addresses", body: attrs)
      Address.new(response.body["data"])
    end

    def retrieve(customer, id)
      response = get_request("customers/#{customer}/addresses/#{id}")
      Address.new(response.body["data"])
    end

    def update(customer, id, attrs)
      response = patch_request("customers/#{customer}/addresses/#{id}", body: attrs)
      Address.new(response.body["data"])
    end

  end
end
