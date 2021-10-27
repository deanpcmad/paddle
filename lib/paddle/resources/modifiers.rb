module Paddle
  class ModifiersResource < Resource

    def list(**params)
      response = post_request("2.0/subscription/modifiers", body: params)
      Collection.from_response(response, type: Modifier)
    end

    def create(subscription_id:, modifier_amount:, **params)
      attrs = {subscription_id: subscription_id, modifier_amount: modifier_amount}
      create_response = post_request("2.0/subscription/modifiers/create", body: attrs.merge(params))

      response = post_request("2.0/subscription/modifiers", body: {subscription_id: subscription_id} )
      Collection.from_response(response, type: Modifier)
    end

    def delete(modifier_id:)
      attrs = {modifier_id: modifier_id}
      response = post_request("2.0/subscription/modifiers/delete", body: attrs)
      return true if response.success?
    end

  end
end
