module Paddle
  class Adjustment < Object

    class << self

      def list(**params)
        response = Client.get_request("adjustments", params: params)
        Collection.from_response(response, type: Adjustment)
      end

      def create(**params)
        response = Client.post_request("adjustments", body: params)
        Adjustment.new(response.body["data"])
      end

    end

  end
end
