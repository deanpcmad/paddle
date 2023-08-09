require "test_helper"

class CustomerTest < Minitest::Test

  def test_customer_list
    customers = Paddle::Customer.list

    assert_equal Paddle::Collection, customers.class
    assert_equal Paddle::Customer, customers.data.first.class
    assert_equal "ctm_01h7dtf1yg8jge7980baqdkjk8", customers.data.first.id
  end

  def test_customer_retrieve
    customer = Paddle::Customer.retrieve("ctm_01h7dtf1yg8jge7980baqdkjk8")

    assert_equal Paddle::Customer, customer.class
    assert_equal "ctm_01h7dtf1yg8jge7980baqdkjk8", customer.id
    assert_equal "dean@mycompany.com", customer.email
  end

  def test_customer_create
    customer = Paddle::Customer.create({name: "Michael Bluth", email: "michael@mycompany.com"})

    assert_equal Paddle::Customer, customer.class
    assert_equal "active", customer.status
    assert_equal "michael@mycompany.com", customer.email
  end

  def test_customer_update
    customer = Paddle::Customer.update("ctm_01h7dth5z8q7df4r73r4jek70g", {email: "gob@bluthcompany.com"})

    assert_equal Paddle::Customer, customer.class
    assert_equal "gob@bluthcompany.com", customer.email
  end

end
