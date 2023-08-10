module Paddle
  class Business < Object

    class << self

      def list(customer:, **params)
        response = Client.get_request("customers/#{customer}/businesses", params: params)
        Collection.from_response(response, type: Business)
      end

      def create(customer:, name:, **params)
        attrs = {name: name}
        response = Client.post_request("customers/#{customer}/businesses", body: attrs.merge(params))
        Business.new(response.body["data"])
      end

      def retrieve(customer:, id:)
        response = Client.get_request("customers/#{customer}/businesses/#{id}")
        Business.new(response.body["data"])
      end

      def update(customer:, id:, **params)
        response = Client.patch_request("customers/#{customer}/businesses/#{id}", body: params)
        Business.new(response.body["data"])
      end

    end

  end
end
