require "test_helper"

class SubscriptionTest < Minitest::Test

  def test_subscription_list
    subscriptions = Paddle::Subscription.list

    assert_equal Paddle::Collection, subscriptions.class
    assert_equal Paddle::Subscription, subscriptions.data.first.class
    assert_equal "sub_01h7dvgvc6we84prca8gdhhr9c", subscriptions.data.first.id
  end

  def test_subscription_retrieve
    subscription = Paddle::Subscription.retrieve(id: "sub_01h7dvgvc6we84prca8gdhhr9c")

    assert_equal Paddle::Subscription, subscription.class
    assert_equal "sub_01h7dvgvc6we84prca8gdhhr9c", subscription.id
    assert_equal "active", subscription.status
  end

  def test_subscription_retrieve_with_extra
    subscription = Paddle::Subscription.retrieve(id: "sub_01h7dvgvc6we84prca8gdhhr9c", extra: "next_transaction")

    assert_equal Paddle::Subscription, subscription.class
    assert_equal "sub_01h7dvgvc6we84prca8gdhhr9c", subscription.id
    assert_equal "active", subscription.status
    assert subscription.next_transaction
  end

  def test_subscription_get_transaction
    transaction = Paddle::Subscription.get_transaction(id: "sub_01h7dvgvc6we84prca8gdhhr9c")

    assert_equal Paddle::Transaction, transaction.class
    assert_equal "txn_01h7dxza6whtgdcnb9f1h377j9", transaction.id
    assert_equal "sub_01h7dvgvc6we84prca8gdhhr9c", transaction.subscription_id
  end

  def test_subscription_preview
    subscription = Paddle::Subscription.preview(id: "sub_01h7dvgvc6we84prca8gdhhr9c",
      items: [
        {
          price_id: "pri_01h7dt1t5fhgpx7c4ze66vg3wt",
          quantity: 2
        }
      ],
      proration_billing_mode: "full_next_billing_period"
    )

    assert_equal Paddle::Subscription, subscription.class
    assert_equal "active", subscription.status
    assert_equal 2, subscription.recurring_transaction_details.line_items.first.quantity
  end

  def test_subscription_update
    subscription = Paddle::Subscription.update(id: "sub_01h7dvgvc6we84prca8gdhhr9c", billing_details: {purchase_order_number: "PO-1234"})

    assert_equal Paddle::Subscription, subscription.class
    assert_equal "active", subscription.status
    assert_equal "sub_01h7dvgvc6we84prca8gdhhr9c", subscription.id
    assert_equal "PO-1234", subscription.billing_details.purchase_order_number
  end

  def test_subscription_pause
    subscription = Paddle::Subscription.pause(id: "sub_01h7dvgvc6we84prca8gdhhr9c", effective_from: "immediately")

    assert_equal Paddle::Subscription, subscription.class
    assert_equal "active", subscription.status
    assert_equal "sub_01h7dvgvc6we84prca8gdhhr9c", subscription.id
    assert_equal "pause", subscription.scheduled_change.action
  end

  # def test_subscription_resume
  #   subscription = Paddle::Subscription.resume "sub_01h7dvgvc6we84prca8gdhhr9c", {
  #     "effective_from": "immediately"
  #   }

  #   assert_equal Paddle::Subscription, subscription.class
  #   assert_equal "active", subscription.status
  #   assert_equal "sub_01h7dvgvc6we84prca8gdhhr9c", subscription.id
  #   # assert_equal "2023-09-20T00:00:00.001Z", subscription.scheduled_change.resume_at
  # end

  def test_subscription_charge
    subscription = Paddle::Subscription.charge(id: "sub_01h7dvgvc6we84prca8gdhhr9c",
      effective_from: "immediately",
      items: [
        {
          price_id: "pri_01h7dy3z54j3q6ehcd0gvk35mb",
          quantity: 1
        }
      ]
    )

    assert_equal Paddle::Subscription, subscription.class
    assert_equal "active", subscription.status
  end

  def test_subscription_cancel
    subscription = Paddle::Subscription.cancel(id: "sub_01h7dvgvc6we84prca8gdhhr9c", effective_from: "next_billing_period")

    assert_equal Paddle::Subscription, subscription.class
    assert_equal "active", subscription.status
    assert_equal "sub_01h7dvgvc6we84prca8gdhhr9c", subscription.id
    assert_equal "cancel", subscription.scheduled_change.action
  end

end
