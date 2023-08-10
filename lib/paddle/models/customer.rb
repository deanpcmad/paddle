module Paddle
  class Customer < Object

    class << self

      def list(**params)
        response = Client.get_request("customers", params: params)
        Collection.from_response(response, type: Customer)
      end

      def create(**params)
        response = Client.post_request("customers", body: params)
        Customer.new(response.body["data"])
      end

      def retrieve(id:)
        response = Client.get_request("customers/#{id}")
        Customer.new(response.body["data"])
      end

      def update(id:, **params)
        response = Client.patch_request("customers/#{id}", body: params)
        Customer.new(response.body["data"])
      end

    end

  end
end
