module Paddle
  module Classic
    class PaymentsResource < Resource
      def list(**params)
        response = post_request("2.0/subscription/payments", body: params)
        Collection.from_response(response, type: Payment)
      end

      def reschedule(payment_id:, date:)
        attrs = { payment_id: payment_id, date: date }
        response = post_request("2.0/subscription/payments_reschedule", body: attrs)
        true if response.success?
      end

      def refund(order_id:, **params)
        attrs = { order_id: order_id }
        response = post_request("2.0/payment/refund", body: attrs.merge(params))
        PaymentRefund.new(response.body["response"])
      end
    end
  end
end
