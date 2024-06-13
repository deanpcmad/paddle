module Paddle
  module Classic
    class LicensesResource < Resource
      def generate(product_id:, allowed_uses:, **params)
        attrs = { product_id: product_id, allowed_uses: allowed_uses }

        response = post_request("2.0/product/generate_license", body: attrs.merge(params))

        License.new(response.body["response"]) if response.success?
      end
    end
  end
end
