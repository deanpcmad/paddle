# frozen_string_literal: true

module Paddle
  class Configuration

    attr_reader :environment

    attr_accessor :version
    attr_accessor :api_key

    def initialize
      @environment ||= :production
      @version ||= 1
    end

    def environment=(env)
      env = env.nil? ? :production : env.to_sym
      unless [:development, :sandbox, :production].include?(env)
        raise ArgumentError, "#{env.inspect} is not a valid environment"
      end
      @environment = env
    end

    def url
      case @environment
      when :production
        "https://api.paddle.com"
      when :development, :sandbox
        "https://sandbox-api.paddle.com"
      end
    end

  end
end
