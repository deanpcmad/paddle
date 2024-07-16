require "test_helper"

class AddressTest < Minitest::Test
  def test_address_list
    addresses = Paddle::Address.list(customer: "ctm_01h7dtf1yg8jge7980baqdkjk8")

    assert_equal Paddle::Collection, addresses.class
    assert_equal Paddle::Address, addresses.data.first.class
    assert_equal "add_01h7dtpj3a5ygxw13fzhw8h445", addresses.data.first.id
  end

  def test_address_retrieve
    address = Paddle::Address.retrieve(customer: "ctm_01h7dtf1yg8jge7980baqdkjk8", id: "add_01h7dtvh64g9c20asb65dc411r")

    assert_equal Paddle::Address, address.class
    assert_equal "add_01h7dtvh64g9c20asb65dc411r", address.id
    assert_equal "124 City Road", address.first_line
  end

  def test_address_create
    address = Paddle::Address.create(customer: "ctm_01h7dtf1yg8jge7980baqdkjk8", country_code: "GB", postal_code: "SW1A 2AA", first_line: "10 Downing Street")

    assert_equal Paddle::Address, address.class
    assert_equal "active", address.status
    assert_equal "10 Downing Street", address.first_line
  end

  def test_address_update
    address = Paddle::Address.update(customer: "ctm_01h7dtf1yg8jge7980baqdkjk8", id: "add_01h7dtvh64g9c20asb65dc411r", description: "Downing Street")

    assert_equal Paddle::Address, address.class
    assert_equal "Downing Street", address.description
  end

  def test_object_update_without_ids
    VCR.use_cassette("test_address_retrieve") do
      Paddle::Address.retrieve(customer: "ctm_01h7dtf1yg8jge7980baqdkjk8", id: "add_01h7dtvh64g9c20asb65dc411r").tap do |address|
        VCR.use_cassette("test_address_update") do
          address.update(description: "Downing Street")
        end

        assert_equal Paddle::Address, address.class
        assert_equal "Downing Street", address.description
      end
    end
  end

  def test_object_update_with_ids
    VCR.use_cassette("test_address_retrieve") do
      Paddle::Address.retrieve(customer: "ctm_01h7dtf1yg8jge7980baqdkjk8", id: "add_01h7dtvh64g9c20asb65dc411r").tap do |address|
        VCR.use_cassette("test_address_update") do
          address.update(description: "Downing Street", customer: "lmao", id: "lmao")
        end

        assert_equal Paddle::Address, address.class
        assert_equal "Downing Street", address.description
        refute_equal "lmao", address.id
        refute_equal "lmao", address.customer_id
      end
    end
  end
end
