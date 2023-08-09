require "test_helper"

class AddressesResourceTest < Minitest::Test

  def test_list
    stub = stub_request("customers/ctm_abc123/addresses", response: "addresses/list")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    addresses = client.addresses.list("ctm_abc123")

    assert_equal Paddle::Collection, addresses.class
    assert_equal Paddle::Address, addresses.data.first.class
    assert_equal "add_01gvczbeepz72bfgsvbcmy1vpg", addresses.data.first.id
  end

  def test_retrieve
    stub = stub_request("customers/ctm_abc123/addresses/add_01gvczbeepz72bfgsvbcmy1vpg", response: "addresses/retrieve")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    address = client.addresses.retrieve("ctm_abc123", "add_01gvczbeepz72bfgsvbcmy1vpg")

    assert_equal Paddle::Address, address.class
    assert_equal "add_01gvczbeepz72bfgsvbcmy1vpg", address.id
    assert_equal "Seawind Unit", address.description
  end

  def test_create
    stub = stub_request("customers/ctm_abc123/addresses", method: :post, response: "addresses/create")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    address = client.addresses.create("ctm_abc123", {country_code: "US", postal_code: "92688", city: "Sudden Valley"})

    assert_equal Paddle::Address, address.class
    assert_equal "active", address.status
    assert_equal "Sudden Valley", address.city
  end

  def test_update
    stub = stub_request("customers/ctm_abc123/addresses/add_01gvcz6r0t0g5cphhwd8n952gb", method: :patch, response: "addresses/update")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    address = client.addresses.update("ctm_abc123", "add_01gvcz6r0t0g5cphhwd8n952gb", {description: "Bluth Company Head Office"})

    assert_equal Paddle::Address, address.class
    assert_equal "Bluth Company Head Office", address.description
  end

end
