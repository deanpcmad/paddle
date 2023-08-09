module Paddle
  class Customer < Object

    class << self

      def list(params = nil)
        response = Client.get_request("customers", params: params)
        Collection.from_response(response, type: Customer)
      end

      def create(attrs)
        response = Client.post_request("customers", body: attrs)
        Customer.new(response.body["data"])
      end

      def retrieve(id)
        response = Client.get_request("customers/#{id}")
        Customer.new(response.body["data"])
      end

      def update(id, attrs)
        response = Client.patch_request("customers/#{id}", body: attrs)
        Customer.new(response.body["data"])
      end

    end

  end
end
