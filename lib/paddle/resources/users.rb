module Paddle
  class UsersResource < Resource

    def list(**params)
      response = post_request("2.0/subscription/users", body: params)
      Collection.from_response(response, type: User)
    end

    def update(subscription_id:, **params)
      attrs = {subscription_id: subscription_id}
      response = post_request("2.0/subscription/users/update", body: attrs.merge(params))
      User.new(response.body["response"]) if response.success?
    end

    def pause(subscription_id:, **params)
      attrs = {subscription_id: subscription_id, pause: true}
      response = post_request("2.0/subscription/users/update", body: attrs.merge(params))
      User.new(response.body["response"]) if response.success?
    end

    def unpause(subscription_id:, **params)
      attrs = {subscription_id: subscription_id, pause: false}
      response = post_request("2.0/subscription/users/update", body: attrs.merge(params))
      User.new(response.body["response"]) if response.success?
    end

    def update_postcode(subscription_id:, postcode:)
      attrs = {subscription_id: subscription_id, postcode: postcode}
      response = post_request("2.0/subscription/users/postcode", body: attrs)
      return true if response.success?
    end

    def cancel(subscription_id:)
      attrs = {subscription_id: subscription_id}
      response = post_request("2.0/subscription/users_cancel", body: attrs)
      return true if response.success?
    end

  end
end
