module Paddle
  module Classic
    class PlansResource < Resource
      def list
        response = post_request("2.0/subscription/plans")
        Collection.from_response(response, type: Plan)
      end

      def create(name:, type:, **params)
        attrs = { plan_name: name, plan_type: type }
        create_response = post_request("2.0/subscription/plans_create", body: attrs.merge(params))

        # After creating the Plan, because it doesn't return the whole record, grab it from the API and return that
        response = post_request("2.0/subscription/plans", body: { plan: create_response.body["response"]["product_id"] })
        Plan.new(response.body.dig("response")[0]) if response.success?
      end
    end
  end
end
