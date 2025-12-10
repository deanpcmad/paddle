module Paddle
  class ClientToken < Object
    class << self
      def list(**params)
        response = Client.get_request("client-tokens", params: params)
        Collection.from_response(response, type: ClientToken)
      end

      def create(name:, **params)
        attrs = { name: name }
        response = Client.post_request("client-tokens", body: attrs.merge(params))
        ClientToken.new(response.body["data"])
      end

      def retrieve(id:)
        response = Client.get_request("client-tokens/#{id}")
        ClientToken.new(response.body["data"])
      end

      def update(id:, **params)
        response = Client.patch_request("client-tokens/#{id}", body: params)
        ClientToken.new(response.body["data"])
      end
    end
  end
end
