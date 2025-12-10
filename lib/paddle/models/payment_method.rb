module Paddle
  class PaymentMethod < Object
    class << self
      def list(customer:, **params)
        response = Client.get_request("customers/#{customer}/payment-methods", params: params)
        Collection.from_response(response, type: PaymentMethod)
      end

      def retrieve(customer:, id:)
        response = Client.get_request("customers/#{customer}/payment-methods/#{id}")
        PaymentMethod.new(response.body["data"])
      end

      def delete(customer:, id:)
        Client.delete_request("customers/#{customer}/payment-methods/#{id}")
      end
    end
  end
end
