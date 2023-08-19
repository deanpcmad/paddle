module Paddle
  class PricingPreview < Object

    class << self

      def generate(items:, **params)
        attrs = {items: items}
        response = Client.post_request("pricing-preview", body: attrs.merge(params))
        PricingPreview.new(response.body["data"])
      end

    end

  end
end
