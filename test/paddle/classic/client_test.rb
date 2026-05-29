require "minitest/autorun"
require "paddle"
require "json"
require "uri"

class ClassicClientTest < Minitest::Test
  def setup
  end

  def teardown
  end

  def test_posts_form_encoded_request_bodies
    stubs = Faraday::Adapter::Test::Stubs.new do |stub|
      stub.post("https://vendors.paddle.com/api/2.0/product/generate_pay_link") do |env|
        params = URI.decode_www_form(env.body).to_h

        assert_equal "application/x-www-form-urlencoded", env.request_headers["Content-Type"]
        assert_equal "123", params["vendor_id"]
        assert_equal "auth-code", params["vendor_auth_code"]
        assert_equal "USD:296.0", params["prices[0]"]
        assert_equal "USD:349.0", params["recurring_prices[0]"]

        [
          200,
          { "Content-Type" => "application/json" },
          { "success" => true, "response" => { "url" => "https://pay.paddle.com/checkout/123" } }.to_json
        ]
      end
    end

    client = Paddle::Classic::Client.new(
      vendor_id: "123",
      vendor_auth_code: "auth-code",
      adapter: :test,
      stubs: stubs
    )

    without_vcr do
      client.pay_links.generate(
        "prices[0]": "USD:296.0",
        "recurring_prices[0]": "USD:349.0"
      )
    end

    stubs.verify_stubbed_calls
  end

  private

  def without_vcr(&block)
    return yield unless defined?(VCR)

    VCR.turned_off(&block)
  end
end
