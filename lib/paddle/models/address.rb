module Paddle
  class Address < Object

    class << self

      def list(customer, params = nil)
        response = Client.get_request("customers/#{customer}/addresses", params: params)
        Collection.from_response(response, type: Address)
      end

      def create(customer, attrs)
        response = Client.post_request("customers/#{customer}/addresses", body: attrs)
        Address.new(response.body["data"])
      end

      def retrieve(customer, id)
        response = Client.get_request("customers/#{customer}/addresses/#{id}")
        Address.new(response.body["data"])
      end

      def update(customer, id, attrs)
        response = Client.patch_request("customers/#{customer}/addresses/#{id}", body: attrs)
        Address.new(response.body["data"])
      end

    end

  end
end
