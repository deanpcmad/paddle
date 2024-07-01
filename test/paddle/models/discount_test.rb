require "test_helper"

class DiscountTest < Minitest::Test
  def test_discount_list
    discounts = Paddle::Discount.list

    assert_equal Paddle::Collection, discounts.class
    assert_equal Paddle::Discount, discounts.data.first.class
    assert_equal "dsc_01h7dtzexhveh8sqfm16b0yw4d", discounts.data.first.id
  end

  def test_discount_retrieve
    discount = Paddle::Discount.retrieve(id: "dsc_01h7dv1243xervzbkfxkg56cnn")

    assert_equal Paddle::Discount, discount.class
    assert_equal "dsc_01h7dv1243xervzbkfxkg56cnn", discount.id
    assert_equal "10% off", discount.description
  end

  def test_discount_create
    discount = Paddle::Discount.create(description: "$10 off", type: "flat", amount: "1000", currency_code: "USD")

    assert_equal Paddle::Discount, discount.class
    assert_equal "active", discount.status
    assert_equal "1000", discount.amount
  end

  def test_discount_update
    discount = Paddle::Discount.update(id: "dsc_01h7dv1243xervzbkfxkg56cnn", code: "WELCOME", enabled_for_checkout: true)

    assert_equal Paddle::Discount, discount.class
    assert_equal "WELCOME", discount.code
  end

  def test_object_update_without_ids
    VCR.use_cassette("test_discount_retrieve") do
      Paddle::Discount.retrieve(id: "dsc_01h7dv1243xervzbkfxkg56cnn").tap do |discount|
        VCR.use_cassette("test_discount_update") do
          discount.update(code: "WELCOME", enabled_for_checkout: true)
        end

        assert_equal Paddle::Discount, discount.class
        assert_equal "WELCOME", discount.code
        assert discount.enabled_for_checkout
      end
    end
  end

  def test_object_update_with_ids
    VCR.use_cassette("test_discount_retrieve") do
      Paddle::Discount.retrieve(id: "dsc_01h7dv1243xervzbkfxkg56cnn").tap do |discount|
        VCR.use_cassette("test_discount_update") do
          discount.update(code: "WELCOME", enabled_for_checkout: true, id: "lmao")
        end

        assert_equal Paddle::Discount, discount.class
        assert_equal "WELCOME", discount.code
        assert discount.enabled_for_checkout
        refute_equal "lmao", discount.id
      end
    end
  end
end
