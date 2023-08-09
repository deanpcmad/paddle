module Paddle
  class SubscriptionsResource < Resource

    def list(params = nil)
      response = get_request("subscriptions", params: params)
      Collection.from_response(response, type: Subscription)
    end

    def retrieve(id)
      response = get_request("subscriptions/#{id}")
      Subscription.new(response.body["data"])
    end

    def get_transaction(id)
      response = get_request("subscriptions/#{id}/update-payment-method-transaction")
      Subscription.new(response.body["data"])
    end

    def preview(id, attrs)
      response = patch_request("subscriptions/#{id}/preview", body: attrs)
      Subscription.new(response.body["data"])
    end

    def update(id, attrs)
      response = patch_request("subscriptions/#{id}", body: attrs)
      Subscription.new(response.body["data"])
    end

    def charge(id, attrs)
      response = post_request("subscriptions/#{id}/charge", body: attrs)
      Subscription.new(response.body["data"])
    end

    def pause(id, attrs)
      response = post_request("subscriptions/#{id}/pause", body: attrs)
      Subscription.new(response.body["data"])
    end

    def resume(id, attrs)
      response = post_request("subscriptions/#{id}/resume", body: attrs)
      Subscription.new(response.body["data"])
    end

    def cancel(id, attrs)
      response = post_request("subscriptions/#{id}/cancel", body: attrs)
      Subscription.new(response.body["data"])
    end

  end
end
