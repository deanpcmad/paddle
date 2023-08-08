module Paddle
  module Classic
    class WebhooksResource < Resource

      def list(**params)
        response = post_request("2.0/alert/webhooks", body: params)
        Collection.from_response(response, type: Webhook, key: "data")
      end

    end
  end
end
