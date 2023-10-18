module Paddle
  class Customer < Object

    class << self

      def list(**params)
        response = Client.get_request("customers", params: params)
        Collection.from_response(response, type: Customer)
      end

      def create(email:, **params)
        attrs = {email: email.gsub(/\s+/, "")}
        response = Client.post_request("customers", body: attrs.merge(params))
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

      def credit(id:)
        response = Client.get_request("customers/#{id}/credit-balances")
        CreditBalance.new(response.body["data"][0])
      end

    end

  end
end
