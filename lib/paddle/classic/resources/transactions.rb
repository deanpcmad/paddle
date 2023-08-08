module Paddle
  module Classic
    class TransactionsResource < Resource

      def list(entity:, id:)
        response = post_request("2.0/#{entity}/#{id}/transactions")
        Collection.from_response(response, type: Transaction)
      end

    end
  end
end
