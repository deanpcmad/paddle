require "test_helper"

class ProductsResourceTest < Minitest::Test

  def test_list
    stub = stub_request("products", response: "products/list")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    products = client.products.list

    assert_equal Paddle::Collection, products.class
    assert_equal Paddle::Product, products.data.first.class
    assert_equal "pro_01gsz97mq9pa4fkyy0wqenepkz", products.data.first.id
  end

  def test_retrieve
    stub = stub_request("products/pro_01gsz4vmqbjk3x4vvtafffd540", response: "products/retrieve")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    product = client.products.retrieve("pro_01gsz4vmqbjk3x4vvtafffd540")

    assert_equal Paddle::Product, product.class
    assert_equal "pro_01gsz4vmqbjk3x4vvtafffd540", product.id
  end

  def test_create
    stub = stub_request("products", method: :post, response: "products/create")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    product = client.products.create({name: "ChatApp Enterprise"})

    assert_equal Paddle::Product, product.class
    assert_equal "ChatApp Enterprise", product.name
  end

  def test_update
    stub = stub_request("products/pro_01gsz4vmqbjk3x4vvtafffd540", method: :patch, response: "products/update")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    product = client.products.update("pro_01gsz4vmqbjk3x4vvtafffd540", {name: "ChatApp Enterprise (old)"})

    assert_equal Paddle::Product, product.class
    assert_equal "ChatApp Enterprise (old)", product.name
  end

end
