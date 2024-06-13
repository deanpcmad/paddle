$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "paddle"
require "minitest/autorun"
require "faraday"
require "json"
require "vcr"
require "dotenv/load"

VCR.configure do |config|
  config.cassette_library_dir = "test/vcr_cassettes"
  config.hook_into :faraday

  config.filter_sensitive_data("<AUTHORIZATION>") { ENV["PADDLE_API_KEY_TEST"] }
end

Paddle.configure do |config|
  config.environment = :sandbox
  config.api_key = ENV["PADDLE_API_KEY_TEST"]
end

class Minitest::Test
  def setup
    VCR.insert_cassette(name)
  end

  def teardown
    VCR.eject_cassette
  end
end
