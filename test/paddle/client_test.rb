require "test_helper"

class ClientTest < Minitest::Test
  def test_api_key
    client = Paddle::Client.new api_key: "abc123"
    assert_equal "abc123", client.api_key
  end

  def test_sandbox
    client = Paddle::Client.new api_key: "abc123", sandbox: true
    assert_equal true, client.sandbox
  end

  def test_url
    client = Paddle::Client.new api_key: "abc123"
    assert_equal "https://api.paddle.com", client.url
  end

  def test_sandbox_url
    client = Paddle::Client.new api_key: "abc123", sandbox: true
    assert_equal "https://sandbox-api.paddle.com", client.url
  end
end
