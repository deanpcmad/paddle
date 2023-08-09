require "test_helper"

class BusinessTest < Minitest::Test

  def test_business_list
    businesses = Paddle::Business.list("ctm_01h7dtf1yg8jge7980baqdkjk8")

    assert_equal Paddle::Collection, businesses.class
    assert_equal Paddle::Business, businesses.data.first.class
    assert_equal "biz_01h7dv63eze6r79924ch5c1rbd", businesses.data.first.id
  end

  def test_business_retrieve
    business = Paddle::Business.retrieve("ctm_01h7dtf1yg8jge7980baqdkjk8", "biz_01h7dv63eze6r79924ch5c1rbd")

    assert_equal Paddle::Business, business.class
    assert_equal "biz_01h7dv63eze6r79924ch5c1rbd", business.id
    assert_equal "My Business", business.name
  end

  def test_business_create
    business = Paddle::Business.create("ctm_01h7dtf1yg8jge7980baqdkjk8", {name: "Business1"})

    assert_equal Paddle::Business, business.class
    assert_equal "active", business.status
    assert_equal "Business1", business.name
  end

  def test_business_update
    business = Paddle::Business.update("ctm_01h7dtf1yg8jge7980baqdkjk8", "biz_01h7dz69ksn40x5zrvekgh1xrn", {company_number: "123123"})

    assert_equal Paddle::Business, business.class
    assert_equal "123123", business.company_number
  end

end
