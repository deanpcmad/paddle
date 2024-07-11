module Paddle
  class Client
    class << self
      def connection
        @connection ||= Faraday.new(Paddle.config.url) do |conn|
          conn.request :authorization, :Bearer, Paddle.config.api_key

          conn.headers = {
            "User-Agent" => "paddle/v#{VERSION} (github.com/deanpcmad/paddle)",
            "Paddle-Version" => Paddle.config.version.to_s
          }

          conn.request :json
          conn.response :json
        end
      end


      def get_request(url, params: {}, headers: {})
        handle_response connection.get(url, params, headers)
      end

      def post_request(url, body: {}, headers: {})
        handle_response connection.post(url, body, headers)
      end

      def patch_request(url, body:, headers: {})
        handle_response connection.patch(url, body, headers)
      end

      def delete_request(url, headers: {})
        handle_response connection.delete(url, headers)
      end

      def handle_response(response)
        case response.status
        when 400, 401, 403, 404, 409, 429, 500, 503, 501
          error = Paddle::ErrorFactory.create(response.body, response.status)
          raise error if error
        when 204
          return true
        end

        if response.body && response.body["error"]
          error = Paddle::ErrorFactory.create(response.body, response.status)
          raise error if error
        end

        response
      end
    end
  end
end
