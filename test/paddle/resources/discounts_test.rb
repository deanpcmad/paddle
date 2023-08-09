require "test_helper"

class DiscountsResourceTest < Minitest::Test

  def test_list
    stub = stub_request("discounts", response: "discounts/list")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    discounts = client.discounts.list

    assert_equal Paddle::Collection, discounts.class
    assert_equal Paddle::Discount, discounts.data.first.class
    assert_equal "dsc_01gtf15svsqzgp9325ss4ebmwt", discounts.data.first.id
  end

  def test_retrieve
    stub = stub_request("discounts/dsc_01gtf15svsqzgp9325ss4ebmwt", response: "discounts/retrieve")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    discount = client.discounts.retrieve("dsc_01gtf15svsqzgp9325ss4ebmwt")

    assert_equal Paddle::Discount, discount.class
    assert_equal "dsc_01gtf15svsqzgp9325ss4ebmwt", discount.id
    assert_equal "$10 off", discount.description
  end

  def test_create
    stub = stub_request("discounts", method: :post, response: "discounts/create")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    discount = client.discounts.create({description: "$10 off", type: "flat", amount: "1000", currency_code: "USD"})

    assert_equal Paddle::Discount, discount.class
    assert_equal "active", discount.status
    assert_equal "1000", discount.amount
  end

  def test_update
    stub = stub_request("discounts/dsc_01gtf15svsqzgp9325ss4ebmwt", method: :patch, response: "discounts/update")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    discount = client.discounts.update("dsc_01gtf15svsqzgp9325ss4ebmwt", {code: "WELCOME", enabled_for_checkout: true})

    assert_equal Paddle::Discount, discount.class
    assert_equal "WELCOME", discount.code
  end

end
