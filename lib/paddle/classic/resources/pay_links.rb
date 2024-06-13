module Paddle
  module Classic
    class PayLinksResource < Resource
      def generate(**params)
        response = post_request("2.0/product/generate_pay_link", body: params)

        PayLink.new(response.body["response"]) if response.success?
      end
    end
  end
end
