require "test_helper"

class CustomersResourceTest < Minitest::Test

  def test_list
    stub = stub_request("customers", response: "customers/list")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    customers = client.customers.list

    assert_equal Paddle::Collection, customers.class
    assert_equal Paddle::Customer, customers.data.first.class
    assert_equal "ctm_01gw1xk43eqy2rrf0cs93zvm6t", customers.data.first.id
  end

  def test_retrieve
    stub = stub_request("customers/ctm_01gvcz30f4d77tfnn60snnyxfd", response: "customers/retrieve")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    customer = client.customers.retrieve("ctm_01gvcz30f4d77tfnn60snnyxfd")

    assert_equal Paddle::Customer, customer.class
    assert_equal "ctm_01gvcz30f4d77tfnn60snnyxfd", customer.id
    assert_equal "michael@bluthcompany.com", customer.email
  end

  def test_create
    stub = stub_request("customers", method: :post, response: "customers/create")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    customer = client.customers.create({name: "Michael Bluth", email: "michael@bluthcompany.com"})

    assert_equal Paddle::Customer, customer.class
    assert_equal "active", customer.status
    assert_equal "michael@bluthcompany.com", customer.email
  end

  def test_update
    stub = stub_request("customers/ctm_01gw1xk43eqy2rrf0cs93zvm6t", method: :patch, response: "customers/update")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    customer = client.customers.update("ctm_01gw1xk43eqy2rrf0cs93zvm6t", {email: "gob@bluthcompany.com"})

    assert_equal Paddle::Customer, customer.class
    assert_equal "gob@bluthcompany.com", customer.email
  end

end
