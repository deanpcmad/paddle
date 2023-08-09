module Paddle
  class Adjustment < Object

    class << self

      def list(params = nil)
        response = Client.get_request("adjustments", params: params)
        Collection.from_response(response, type: Adjustment)
      end

      def create(attrs)
        response = Client.post_request("adjustments", body: attrs)
        Adjustment.new(response.body["data"])
      end

    end

  end
end
