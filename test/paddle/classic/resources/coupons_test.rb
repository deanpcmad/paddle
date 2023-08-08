require "test_helper"

class ClassicCouponsResourceTest < Minitest::Test

  def test_list
    stub = stub_request("2.0/product/list_coupons", response: "classic/coupons/list")
    client = Paddle::Classic::Client.new(vendor_id: "123", vendor_auth_code: "abc", adapter: :test, stubs: stub)

    coupons = client.coupons.list(product_id: "123")

    assert_equal Paddle::Classic::Coupon, coupons.data.first.class
    assert_equal "56604810a6990", coupons.data.first.coupon
  end

end
