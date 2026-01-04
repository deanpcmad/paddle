require "test_helper"

class DiscountGroupTest < Minitest::Test
  def test_discount_group_list
    discount_groups = Paddle::DiscountGroup.list

    assert_equal Paddle::Collection, discount_groups.class
    assert_equal Paddle::DiscountGroup, discount_groups.data.first.class
    assert_equal "dsg_01kdnzzfakgpvj1ky1rtb43cs5", discount_groups.data.first.id
  end

  def test_discount_group_retrieve
    discount_group = Paddle::DiscountGroup.retrieve(id: "dsg_01kdnzzfakgpvj1ky1rtb43cs5")

    assert_equal Paddle::DiscountGroup, discount_group.class
    assert_equal "dsg_01kdnzzfakgpvj1ky1rtb43cs5", discount_group.id
    assert_equal "Test group", discount_group.name
  end

  def test_discount_group_create
    discount_group = Paddle::DiscountGroup.create(name: "Black Friday Promotion")

    assert_equal Paddle::DiscountGroup, discount_group.class
    assert_equal "Black Friday Promotion", discount_group.name
    assert_equal "active", discount_group.status
  end

  def test_discount_group_update
    discount_group = Paddle::DiscountGroup.update(id: "dsg_01kdnzzfakgpvj1ky1rtb43cs5", name: "Winter Sale")

    assert_equal Paddle::DiscountGroup, discount_group.class
    assert_equal "Winter Sale", discount_group.name
  end

  def test_object_update_without_ids
    VCR.use_cassette("test_discount_group_retrieve") do
      Paddle::DiscountGroup.retrieve(id: "dsg_01kdnzzfakgpvj1ky1rtb43cs5").tap do |discount_group|
        VCR.use_cassette("test_discount_group_update") do
          discount_group.update(name: "Winter Sale")
        end

        assert_equal Paddle::DiscountGroup, discount_group.class
        assert_equal "Winter Sale", discount_group.name
      end
    end
  end

  def test_object_update_with_ids
    VCR.use_cassette("test_discount_group_retrieve") do
      Paddle::DiscountGroup.retrieve(id: "dsg_01kdnzzfakgpvj1ky1rtb43cs5").tap do |discount_group|
        VCR.use_cassette("test_discount_group_update") do
          discount_group.update(name: "Winter Sale", id: "lmao")
        end

        assert_equal Paddle::DiscountGroup, discount_group.class
        assert_equal "Winter Sale", discount_group.name
        refute_equal "lmao", discount_group.id
      end
    end
  end

  def test_discount_group_create_discount
    discount_group_id = "dsg_01kdnzzfakgpvj1ky1rtb43cs5"
    discount_group = Paddle::DiscountGroup.new(id: discount_group_id)
    discount = discount_group.create_discount(description: "$10 off", type: "flat", amount: "1000", currency_code: "USD")

    assert_equal Paddle::Discount, discount.class
    assert_equal "$10 off", discount.description
    assert_equal "flat", discount.type
    assert_equal "1000", discount.amount
    assert_equal "USD", discount.currency_code
    assert_equal discount_group_id, discount.discount_group_id
  end

  def test_discount_group_discounts
    discount_group_id = "dsg_01kdnzzfakgpvj1ky1rtb43cs5"
    discount_group = Paddle::DiscountGroup.new(id: discount_group_id)
    discounts = discount_group.discounts

    assert_equal Paddle::Collection, discounts.class
    assert_equal Paddle::Discount, discounts.first.class
    assert_equal discount_group_id, discounts.first.discount_group_id
  end
end
