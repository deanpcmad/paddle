module Paddle
  class Collection
    attr_reader :data, :total

    def self.from_response(response, type:, key: nil)
      body = response.body

      if key.is_a?(String)
        data  = body["response"][key].map { |attrs| type.new(attrs) }
        total = body["response"]["total"]
      else
        data  = body["response"].map { |attrs| type.new(attrs) }
        total = body["response"].count
      end

      new(
        data: data,
        total: total
      )
    end

    def initialize(data:, total:)
      @data = data
      @total = total
    end
  end
end
