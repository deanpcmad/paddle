module Paddle
  class EventType < Object
    class << self
      def list
        response = Client.get_request("event-types")
        Collection.from_response(response, type: EventType)
      end
    end
  end
end
