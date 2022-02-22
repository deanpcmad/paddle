require "test_helper"

class ClientTest < Minitest::Test
  def test_vendor_id
    client = Paddle::Client.new vendor_id: "123", vendor_auth_code: "abc"
    assert_equal "123", client.vendor_id
  end

  def test_vendor_auth_code
    client = Paddle::Client.new vendor_id: "123", vendor_auth_code: "abc"
    assert_equal "abc", client.vendor_auth_code
  end

  def test_sandbox
    client = Paddle::Client.new vendor_id: "123", vendor_auth_code: "abc", sandbox: true
    assert_equal true, client.sandbox
  end
end
