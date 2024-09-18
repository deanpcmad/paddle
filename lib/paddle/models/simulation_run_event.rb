module Paddle
  class SimulationRunEvent < Object
    class << self
      def retrieve(simulation_id:, run_id:, id:)
        response = Client.get_request("simulations/#{simulation_id}/runs/#{run_id}/events/#{id}")
        SimulationRunEvent.new(response.body["data"])
      end

      def replay(simulation_id:, run_id:, id:)
        response = Client.post_request("simulations/#{simulation_id}/runs/#{run_id}/events/#{id}/replay")
        SimulationRunEvent.new(response.body["data"])
      end
    end
  end
end
