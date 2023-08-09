module Paddle
  class Event < Object

    class << self

      def list(params = nil)
        response = Client.get_request("events", params: params)
        Collection.from_response(response, type: Event)
      end

    end

  end
end
