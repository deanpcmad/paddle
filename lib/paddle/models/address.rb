module Paddle
  class Address < Object
    class << self
      def list(customer:, **params)
        response = Client.get_request("customers/#{customer}/addresses", params: params)
        Collection.from_response(response, type: Address)
      end

      def create(customer:, country_code:, postal_code:, **params)
        attrs = { country_code: country_code, postal_code: postal_code }
        response = Client.post_request("customers/#{customer}/addresses", body: attrs.merge(params))
        Address.new(response.body["data"])
      end

      def retrieve(customer:, id:)
        response = Client.get_request("customers/#{customer}/addresses/#{id}")
        Address.new(response.body["data"])
      end

      def update(customer:, id:, **params)
        response = Client.patch_request("customers/#{customer}/addresses/#{id}", body: params)
        Address.new(response.body["data"])
      end
    end
  end
end
