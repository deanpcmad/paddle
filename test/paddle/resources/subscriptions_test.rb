require "test_helper"

class SubscriptionsResourceTest < Minitest::Test

  def test_list
    stub = stub_request("subscriptions", response: "subscriptions/list")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    subscriptions = client.subscriptions.list

    assert_equal Paddle::Collection, subscriptions.class
    assert_equal Paddle::Subscription, subscriptions.data.first.class
    assert_equal "sub_01gt25ckjxg1v11jnq9dnrkpfz", subscriptions.data.first.id
  end

  def test_retrieve
    stub = stub_request("subscriptions/sub_01gt25ckjxg1v11jnq9dnrkpfz", response: "subscriptions/retrieve")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    subscription = client.subscriptions.retrieve "sub_01gt25ckjxg1v11jnq9dnrkpfz"

    assert_equal Paddle::Subscription, subscription.class
    assert_equal "sub_01gt25ckjxg1v11jnq9dnrkpfz", subscription.id
  end

  def test_preview
    stub = stub_request("subscriptions/sub_01gt25ckjxg1v11jnq9dnrkpfz/preview", method: :patch, response: "subscriptions/preview")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    subscription = client.subscriptions.preview "sub_01gt25ckjxg1v11jnq9dnrkpfz", {
      "items": [
        {
          "price_id": "pri_01gsz8x8sawmvhz1pv30nge1ke",
          "quantity": 20
        },
        {
          "price_id": "pri_01gsz95g2zrkagg294kpstx54r",
          "quantity": 1
        }
      ],
      "proration_billing_mode": "prorated_immediately"
    }

    assert_equal Paddle::Subscription, subscription.class
    assert_equal "active", subscription.status
    assert_equal "pri_01gsz8x8sawmvhz1pv30nge1ke", subscription.recurring_transaction_details.line_items.first.price_id
  end

  def test_update
    stub = stub_request("subscriptions/sub_01gw99spk043n12h7ej3rwbqcs", method: :patch, response: "subscriptions/update")

    client = Paddle::Client.new(api_key: "abc", adapter: :test, stubs: stub)

    subscription = client.subscriptions.update "sub_01gw99spk043n12h7ej3rwbqcs", {
      "billing_details": {"purchase_order_number": "PO-1234"}
    }

    assert_equal Paddle::Subscription, subscription.class
    assert_equal "active", subscription.status
    assert_equal "sub_01gw99spk043n12h7ej3rwbqcs", subscription.id
    assert_equal "PO-1234", subscription.billing_details.purchase_order_number
  end

end
