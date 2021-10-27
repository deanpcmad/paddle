module Paddle
  class ChargesResource < Resource

    def create(subscription_id:, amount:, charge_name:)
      attrs = {amount: amount, charge_name: charge_name}
      response = post_request("2.0/subscription/#{subscription_id}/charge", body: attrs)
      Charge.new(response.body["response"])
    end

  end
end
