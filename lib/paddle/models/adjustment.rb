module Paddle
  class Adjustment < Object
    class << self
      def list(**params)
        response = Client.get_request("adjustments", params: params)
        Collection.from_response(response, type: Adjustment)
      end

      def create(transaction_id:, action:, reason:, items:, **params)
        attrs = { transaction_id: transaction_id, action: action, reason: reason, items: items }
        response = Client.post_request("adjustments", body: attrs.merge(params))
        Adjustment.new(response.body["data"])
      end

      def credit_note(id:, disposition: "attachment")
        response = Client.get_request("adjustments/#{id}/credit-note?disposition=#{disposition}")
        if response.success?
          response.body["data"]["url"]
        end
      end
    end
  end
end
