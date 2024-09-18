module Paddle
  class SimulationType < Object
    class << self
      def list
        response = Client.get_request("simulation-types")
        Collection.from_response(response, type: SimulationType)
      end
    end
  end
end
