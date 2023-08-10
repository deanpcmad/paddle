module Paddle
  class Transaction < Object

    class << self

      def list(**params)
        response = Client.get_request("transactions", params: params)
        Collection.from_response(response, type: Transaction)
      end

      def create(items:, **params)
        attrs = {items: items}
        response = Client.post_request("transactions", body: attrs.merge(params))
        Transaction.new(response.body["data"])
      end

      def retrieve(id:)
        response = Client.get_request("transactions/#{id}")
        Transaction.new(response.body["data"])
      end

      def update(id:, **params)
        response = Client.patch_request("transactions/#{id}", body: params)
        Transaction.new(response.body["data"])
      end

      def invoice(id:)
        response = Client.get_request("transactions/#{id}/invoice")
        if response.success?
          return response.body["data"]["url"]
        end
      end

      def preview(items:, **params)
        attrs = {items: items}
        response = Client.post_request("transactions/preview", body: attrs.merge(params))
        Transaction.new(response.body["data"])
      end

      def preview_prices(items:, **params)
        attrs = {items: items}
        response = Client.post_request("pricing-preview", body: attrs.merge(params))
        Transaction.new(response.body["data"])
      end

    end

  end
end
