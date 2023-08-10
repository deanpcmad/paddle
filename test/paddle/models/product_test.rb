require "test_helper"

class ProductTest < Minitest::Test

  def test_product_list
    products = Paddle::Product.list

    assert_equal Paddle::Collection, products.class
    assert_equal Paddle::Product, products.data.first.class
    assert_equal "pro_01h7dsrdafzk113p2fbj07wpfd", products.data.first.id
  end

  def test_product_retrieve
    product = Paddle::Product.retrieve(id: "pro_01h7dsrdafzk113p2fbj07wpfd")

    assert_equal Paddle::Product, product.class
    assert_equal "pro_01h7dsrdafzk113p2fbj07wpfd", product.id
    assert_equal "Test Product 1", product.name
  end

  def test_product_create
    product = Paddle::Product.create(name: "ChatApp Enterprise", tax_category: "standard")

    assert_equal Paddle::Product, product.class
    assert_equal "ChatApp Enterprise", product.name
  end

  def test_product_update
    product = Paddle::Product.update(id: "pro_01h7dsxd2sg6aky4e70p96rb1y", name: "ChatApp Enterprise (old)")

    assert_equal Paddle::Product, product.class
    assert_equal "ChatApp Enterprise (old)", product.name
  end

end
