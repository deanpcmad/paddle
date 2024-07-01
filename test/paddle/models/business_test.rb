require "test_helper"

class BusinessTest < Minitest::Test
  def test_business_list
    businesses = Paddle::Business.list(customer: "ctm_01h7dtf1yg8jge7980baqdkjk8")

    assert_equal Paddle::Collection, businesses.class
    assert_equal Paddle::Business, businesses.data.first.class
    assert_equal "biz_01h7dv63eze6r79924ch5c1rbd", businesses.data.first.id
  end

  def test_business_retrieve
    business = Paddle::Business.retrieve(customer: "ctm_01h7dtf1yg8jge7980baqdkjk8", id: "biz_01h7dz69ksn40x5zrvekgh1xrn")

    assert_equal Paddle::Business, business.class
    assert_equal "biz_01h7dz69ksn40x5zrvekgh1xrn", business.id
    assert_equal "My Business", business.name
  end

  def test_business_create
    business = Paddle::Business.create(customer: "ctm_01h7dtf1yg8jge7980baqdkjk8", name: "Business1")

    assert_equal Paddle::Business, business.class
    assert_equal "active", business.status
    assert_equal "Business1", business.name
  end

  def test_business_update
    business = Paddle::Business.update(customer: "ctm_01h7dtf1yg8jge7980baqdkjk8", id: "biz_01h7dz69ksn40x5zrvekgh1xrn", company_number: "123123")

    assert_equal Paddle::Business, business.class
    assert_equal "123123", business.company_number
  end

  def test_object_update_without_ids
    VCR.use_cassette("test_business_retrieve") do
      Paddle::Business.retrieve(customer: "ctm_01h7dtf1yg8jge7980baqdkjk8", id: "biz_01h7dz69ksn40x5zrvekgh1xrn").tap do |business|
        VCR.use_cassette("test_business_update") do
          business.update(company_number: "123123")
        end

        assert_equal Paddle::Business, business.class
        assert_equal "123123", business.company_number
      end
    end
  end

  def test_object_update_with_ids
    VCR.use_cassette("test_business_retrieve") do
      Paddle::Business.retrieve(customer: "ctm_01h7dtf1yg8jge7980baqdkjk8", id: "biz_01h7dz69ksn40x5zrvekgh1xrn").tap do |business|
        VCR.use_cassette("test_business_update") do
          business.update(company_number: "123123", customer: "lmao", id: "lmao")
        end

        assert_equal Paddle::Business, business.class
        assert_equal "123123", business.company_number
        refute_equal "lmao", business.id
        refute_equal "lmao", business.customer_id
      end
    end
  end
end
