require "test_helper"

class PriceTest < Minitest::Test

  def test_price_list
    prices = Paddle::Price.list

    assert_equal Paddle::Collection, prices.class
    assert_equal Paddle::Price, prices.data.first.class
    assert_equal "pri_01h7dt1t5fhgpx7c4ze66vg3wt", prices.data.first.id
  end

  def test_price_retrieve
    price = Paddle::Price.retrieve(id: "pri_01h7dt1t5fhgpx7c4ze66vg3wt")

    assert_equal Paddle::Price, price.class
    assert_equal "pri_01h7dt1t5fhgpx7c4ze66vg3wt", price.id
    assert_equal "Monthly", price.description
  end

  def test_price_create
    price = Paddle::Price.create(
      product_id: "pro_01h7dsxd2sg6aky4e70p96rb1y",
      description: "Annual (per seat)",
      amount: "1000",
      currency: "GBP"
    )

    assert_equal Paddle::Price, price.class
    assert_equal "pro_01h7dsxd2sg6aky4e70p96rb1y", price.product_id
    assert_equal "Annual (per seat)", price.description
  end

  def test_price_update
    price = Paddle::Price.update(id: "pri_01h7dt8qgnh9jya9gcqsxd0r7p", description: "Annual (per seat) with 30 day trial")

    assert_equal Paddle::Price, price.class
    assert_equal "Annual (per seat) with 30 day trial", price.description
  end

end
