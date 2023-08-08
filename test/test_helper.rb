$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "paddle"
require "minitest/autorun"
require "faraday"
require "json"

class Minitest::Test

  def stub_response(fixture:, status: 200, headers: {"Content-Type" => "application/json"})
    [status, headers, File.read("test/fixtures/#{fixture}.json")]
  end

  def stub_classic_request(path, response:, body: {})
    stubs = Faraday::Adapter::Test::Stubs.new
    stubs.post("/api/#{path}") do
      stub_response(fixture: response)
    end
    stubs
  end

  def stub_request(path, response:, method: :get, body: {})
    stubs = Faraday::Adapter::Test::Stubs.new
    if method == :get
      stubs.get(path) { stub_response(fixture: response) }
    elsif method == :post
      stubs.post(path) { stub_response(fixture: response) }
    elsif method == :patch
      stubs.patch(path) { stub_response(fixture: response) }
    end
    stubs
  end

end
