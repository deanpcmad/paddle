require "test_helper"

class ClassicClientTest < Minitest::Test
  def test_vendor_id
    client = Paddle::Classic::Client.new vendor_id: "123", vendor_auth_code: "abc"
    assert_equal "123", client.vendor_id
  end

  def test_vendor_auth_code
    client = Paddle::Classic::Client.new vendor_id: "123", vendor_auth_code: "abc"
    assert_equal "abc", client.vendor_auth_code
  end

  def test_sandbox
    client = Paddle::Classic::Client.new vendor_id: "123", vendor_auth_code: "abc", sandbox: true
    assert_equal true, client.sandbox
  end

  def test_url
    client = Paddle::Classic::Client.new vendor_id: "123", vendor_auth_code: "abc"
    assert_equal "https://vendors.paddle.com/api", client.url
  end

  def test_sandbox_url
    client = Paddle::Classic::Client.new vendor_id: "123", vendor_auth_code: "abc", sandbox: true
    assert_equal "https://sandbox-vendors.paddle.com/api", client.url
  end
end
