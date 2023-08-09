module Paddle
  class Business < Object

    class << self

      def list(customer, params = nil)
        response = Client.get_request("customers/#{customer}/businesses", params: params)
        Collection.from_response(response, type: Business)
      end

      def create(customer, attrs)
        response = Client.post_request("customers/#{customer}/businesses", body: attrs)
        Business.new(response.body["data"])
      end

      def retrieve(customer, id)
        response = Client.get_request("customers/#{customer}/businesses/#{id}")
        Business.new(response.body["data"])
      end

      def update(customer, id, attrs)
        response = Client.patch_request("customers/#{customer}/businesses/#{id}", body: attrs)
        Business.new(response.body["data"])
      end

    end

  end
end
