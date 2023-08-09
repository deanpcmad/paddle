module Paddle
  class Collection
    attr_reader :data, :total

    def self.from_response(response, type:)
      body = response.body

      data  = body["data"].map { |attrs| type.new(attrs) }

      if body["meta"]["pagination"]
        total = body["meta"]["pagination"]["estimated_total"]
      else
        total = body["data"].count
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
