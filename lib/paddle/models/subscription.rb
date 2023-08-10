module Paddle
  class Subscription < Object

    class << self

      def list(**params)
        response = Client.get_request("subscriptions", params: params)
        Collection.from_response(response, type: Subscription)
      end

      def retrieve(id:)
        response = Client.get_request("subscriptions/#{id}")
        Subscription.new(response.body["data"])
      end

      def get_transaction(id:)
        response = Client.get_request("subscriptions/#{id}/update-payment-method-transaction")
        Subscription.new(response.body["data"])
      end

      def preview(id:, **params)
        response = Client.patch_request("subscriptions/#{id}/preview", body: params)
        Subscription.new(response.body["data"])
      end

      def update(id:, **params)
        response = Client.patch_request("subscriptions/#{id}", body: params)
        Subscription.new(response.body["data"])
      end

      def charge(id:, items:, effective_from:, **params)
        attrs = {items: items, effective_from: effective_from}
        response = Client.post_request("subscriptions/#{id}/charge", body: attrs.merge(params))
        Subscription.new(response.body["data"])
      end

      def pause(id:, **params)
        response = Client.post_request("subscriptions/#{id}/pause", body: params)
        Subscription.new(response.body["data"])
      end

      def resume(id:, effective_from:, **params)
        attrs = {effective_from: effective_from}
        response = Client.post_request("subscriptions/#{id}/resume", body: attrs.merge(params))
        Subscription.new(response.body["data"])
      end

      def cancel(id:, **params)
        response = Client.post_request("subscriptions/#{id}/cancel", body: params)
        Subscription.new(response.body["data"])
      end

    end

  end
end
