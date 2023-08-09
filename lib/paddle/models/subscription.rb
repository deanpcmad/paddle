module Paddle
  class Subscription < Object

    class << self

      def list(params = nil)
        response = Client.get_request("subscriptions", params: params)
        Collection.from_response(response, type: Subscription)
      end

      def retrieve(id)
        response = Client.get_request("subscriptions/#{id}")
        Subscription.new(response.body["data"])
      end

      def get_transaction(id)
        response = Client.get_request("subscriptions/#{id}/update-payment-method-transaction")
        Subscription.new(response.body["data"])
      end

      def preview(id, attrs)
        response = Client.patch_request("subscriptions/#{id}/preview", body: attrs)
        Subscription.new(response.body["data"])
      end

      def update(id, attrs)
        response = Client.patch_request("subscriptions/#{id}", body: attrs)
        Subscription.new(response.body["data"])
      end

      def charge(id, attrs)
        response = Client.post_request("subscriptions/#{id}/charge", body: attrs)
        Subscription.new(response.body["data"])
      end

      def pause(id, attrs)
        response = Client.post_request("subscriptions/#{id}/pause", body: attrs)
        Subscription.new(response.body["data"])
      end

      def resume(id, attrs)
        response = Client.post_request("subscriptions/#{id}/resume", body: attrs)
        Subscription.new(response.body["data"])
      end

      def cancel(id, attrs)
        response = Client.post_request("subscriptions/#{id}/cancel", body: attrs)
        Subscription.new(response.body["data"])
      end

    end

  end
end
