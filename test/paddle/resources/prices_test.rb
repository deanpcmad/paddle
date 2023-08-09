require "test_helper"

class PricesResourceTest < Minitest::Test

  def test_list
    stub = stub_request("prices", response: "prices/list")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    prices = client.prices.list

    assert_equal Paddle::Collection, prices.class
    assert_equal Paddle::Price, prices.data.first.class
    assert_equal "pri_01gsz98e27ak2tyhexptwc58yk", prices.data.first.id
  end

  def test_retrieve
    stub = stub_request("prices/pri_01gsz8z1q1n00f12qt82y31smh", response: "prices/retrieve")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    price = client.prices.retrieve("pri_01gsz8z1q1n00f12qt82y31smh")

    assert_equal Paddle::Price, price.class
    assert_equal "pri_01gsz8z1q1n00f12qt82y31smh", price.id
    assert_equal "Annual (per seat)", price.description
  end

  def test_create
    stub = stub_request("prices", method: :post, response: "prices/create")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    price = client.prices.create({product_id: "pro_01gsz4t5hdjse780zja8vvr7jg", description: "Annual (per seat)"})

    assert_equal Paddle::Price, price.class
    assert_equal "pro_01gsz4t5hdjse780zja8vvr7jg", price.product_id
    assert_equal "Annual (per seat)", price.description
  end

  def test_update
    stub = stub_request("prices/pri_01gsz8z1q1n00f12qt82y31smh", method: :patch, response: "prices/update")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    price = client.prices.update("pri_01gsz8z1q1n00f12qt82y31smh", {name: "Annual (per seat) with 30 day trial"})

    assert_equal Paddle::Price, price.class
    assert_equal "Annual (per seat) with 30 day trial", price.description
  end

end
