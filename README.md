# Paddle Ruby Library

A Ruby library for the Paddle APIs, both Classic and Billing.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "paddle", "~> 2.0"
```

## Billing API

For accessing the new Billing API from Paddle. For more info, view the [Paddle Billing](https://www.paddle.com/billing) page.

### Configuration

Firstly you'll need to generate and set your API Key and the environment.

You can find and generate an API key [here for production](https://vendors.paddle.com/authentication),
or [here for sandbox](https://sandbox-vendors.paddle.com/authentication)

```ruby
Paddle.configure do |config|
  # Use :development or :sandbox for the Sandbox API
  # Or use :production for the Production API
  config.environment = :sandbox
  config.api_key = ENV["PADDLE_API_KEY"]

  # Set the API version. Defaults to 1
  config.version = 1
end
```

### Products

```ruby
# List all products
# https://developer.paddle.com/api-reference/products/list-products
Paddle::Product.list
Paddle::Product.list(status: "active")
Paddle::Product.list(status: "archived")
Paddle::Product.list(tax_category: "saas")

# Create a product
# https://developer.paddle.com/api-reference/products/create-product
Paddle::Product.create(name: "My SAAS Plan", tax_category: "saas")
Paddle::Product.create(name: "My Standard Product", tax_category: "standard")

# Retrieve a product
Paddle::Product.retrieve(id: "pro_abc123")

# Update a product
# https://developer.paddle.com/api-reference/products/update-product
Paddle::Product.update(id: "pro_abc123", description: "This is a plan")
```

### Prices

```ruby
# List all prices
# https://developer.paddle.com/api-reference/prices/list-prices
Paddle::Price.list
Paddle::Price.list(status: "active")
Paddle::Price.list(status: "archived")
Paddle::Price.list(product_id: "pro_abc123")

# Create a price
# Note that unit_price amount should be a string
# https://developer.paddle.com/api-reference/prices/create-price
Paddle::Price.create(product_id: "pro_abc123", description: "A one off price", amount: "1000", currency: "GBP")

# Retrieve a price
Paddle::Price.retrieve(id: "pri_123abc")

# Update a price
# https://developer.paddle.com/api-reference/prices/update-price
Paddle::Price.update(id: "pri_123abc", description: "An updated description")
```

### Pricing Preview

```ruby
# Preview calculations for one or more prices
# This is normally used when building pricing pages
# https://developer.paddle.com/api-reference/pricing-preview/preview-prices
Paddle::PricingPreview.generate(items: [ { price_id: "pri_123abc", quantity: 5 } ])
Paddle::PricingPreview.generate(items: [ { price_id: "pri_123abc", quantity: 5 } ], currency_code: "GBP")
Paddle::PricingPreview.generate(items: [ { price_id: "pri_123abc", quantity: 5 } ], customer_ip_address: "1.1.1.1")
```

### Discounts

```ruby
# List all discounts
# https://developer.paddle.com/api-reference/discounts/list-discounts
Paddle::Discount.list
Paddle::Discount.list(status: "active")

# Create a discount
# Note that amount should be a string
# https://developer.paddle.com/api-reference/discounts/create-discount
Paddle::Discount.create(description: "$5 off", type: "flat", amount: "500", currency_code: "USD")
Paddle::Discount.create(description: "10% Off", type: "percentage", amount: "10", code: "10OFF")

# Retrieve a discount
Paddle::Discount.retrieve(id: "dsc_abc123")

# Update a discount
# https://developer.paddle.com/api-reference/discounts/update-discount
Paddle::Discount.update(id: "dsc_abc123", description: "An updated description")
```

### Customers

```ruby
# List all customers
# https://developer.paddle.com/api-reference/customers/list-customers
Paddle::Customer.list
Paddle::Customer.list(status: "active")

# Create a customer
# https://developer.paddle.com/api-reference/customers/create-customer
Paddle::Customer.create(email: "myemail@mydomain.com", name: "Customer Name")

# Retrieve a customer
Paddle::Customer.retrieve(id: "ctm_abc123")

# Update a customer
# https://developer.paddle.com/api-reference/customers/update-customer
Paddle::Customer.update(id: "ctm_abc123", status: "archived")
```

### Addresses

```ruby
# List all addresses for a customer
# https://developer.paddle.com/api-reference/addresses/list-addresses
Paddle::Address.list(customer: "ctm_abc123")

# Create an address
# https://developer.paddle.com/api-reference/addresses/create-address
Paddle::Address.create(customer: "ctm_abc123", country_code: "GB", postal_code: "SW1A 2AA")

# Retrieve an address
Paddle::Address.retrieve(customer: "ctm_abc123", id: "add_abc123")

# Update an address
# https://developer.paddle.com/api-reference/addresses/update-address
Paddle::Address.update(customer: "ctm_abc123", id: "add_abc123", status: "archived")
```

### Businesses

```ruby
# List all businesses for a customer
# https://developer.paddle.com/api-reference/businesses/list-businesses
Paddle::Business.list(customer: "ctm_abc123")

# Create a business
# https://developer.paddle.com/api-reference/businesses/create-business
Paddle::Business.create(customer: "ctm_abc123", name: "My Ltd Company")

# Retrieve a business
Paddle::Business.retrieve(customer: "ctm_abc123", id: "biz_abc123")

# Update a business
# https://developer.paddle.com/api-reference/businesses/update-business
Paddle::Business.update(customer: "ctm_abc123", id: "biz_abc123", status: "archived")
```

### Transactions

```ruby
# List all transactions
# https://developer.paddle.com/api-reference/transactions/list-transactions
Paddle::Transaction.list(customer_id: "ctm_abc123")
Paddle::Transaction.list(subscription_id: "sub_abc123")
Paddle::Transaction.list(status: "completed")

# Create a transaction
# https://developer.paddle.com/api-reference/transactions/create-transaction
Paddle::Transaction.create(items: [ { price_id: "pri_abc123", quantity: 1 } ])

# Retrieve a transaction
Paddle::Transaction.retrieve(id: "txn_abc123")

# Update a transaction
# https://developer.paddle.com/api-reference/transaction/update-transaction
Paddle::Transaction.update(id: "txn_abc123", items: [ { price_id: "pri_abc123", quantity: 2 } ])

# Preview a transaction
# https://developer.paddle.com/api-reference/transaction/preview-transaction
Paddle::Transaction.preview(items: [ { price_id: "pri_123abc", quantity: 5 } ])

# Get a PDF invoice for a transaction
# Returns a raw URL. This URL is not permanent and will expire.
# https://developer.paddle.com/api-reference/transaction/get-invoice-pdf
Paddle::Transaction.invoice(id: "txn_abc123")
#=> https://paddle-sandbox-invoice...
```

### Subscriptions

```ruby
# List all subscriptions
# https://developer.paddle.com/api-reference/subscriptions/list-subscriptions
Paddle::Subscription.list(customer_id: "ctm_abc123")
Paddle::Subscription.list(price_id: "pri_abc123")
Paddle::Subscription.list(status: "active")
Paddle::Subscription.list(status: "canceled")

# Retrieve a subscription
Paddle::Subscription.retrieve(id: "sub_abc123")

# Preview an update to a subscription
# https://developer.paddle.com/api-reference/subscriptions/preview-subscription
Paddle::Subscription.preview(id: "sub_abc123", items: [ { price_id: "pri_123abc", quantity: 2 } ])

# Update a subscription
# https://developer.paddle.com/api-reference/subscriptions/update-subscription
Paddle::Subscription.update(id: "sub_abc123", billing_details: {purchase_order_number: "PO-1234"})

# Get a transaction to update payment method
# https://developer.paddle.com/api-reference/subscriptions/update-payment-method
Paddle::Subscription.get_transaction(id: "sub_abc123")

# Create a one-time charge for a subscription
# https://developer.paddle.com/api-reference/subscriptions/create-one-time-charge
Paddle::Subscription.charge(id: "sub_abc123", items: [ { price_id: "pri_123abc", quantity: 2 } ], effective_from: "immediately")

# Pause a subscription
# https://developer.paddle.com/api-reference/subscriptions/pause-subscription
Paddle::Subscription.pause(id: "sub_abc123")
Paddle::Subscription.pause(id: "sub_abc123", effective_from: "next_billing_period")

# Resume a paused subscription
# https://developer.paddle.com/api-reference/subscriptions/resume-subscription
Paddle::Subscription.resume(id: "sub_abc123", effective_from: "next_billing_period")

# Cancel a subscription
# https://developer.paddle.com/api-reference/subscriptions/cancel-subscription
Paddle::Subscription.cancel(id: "sub_abc123", effective_from: "next_billing_period")
```

### Adjustments

```ruby
# List all adjustments
# https://developer.paddle.com/api-reference/adjustments/list-adjustments
Paddle::Adjustment.list(subscription_id: "sub_abc123")
Paddle::Adjustment.list(transaction_id: "txn_abc123")
Paddle::Adjustment.list(action: "refund")

# Create an adjustment
# https://developer.paddle.com/api-reference/adjustments/create-adjustment
Paddle::Adjustment.create(
  action: "refund",
  transaction_id: "txn_abc123",
  reason: "Requested by customer",
  items: [
    {
      type: "full",
      item_id: "txnitm_anc123"
    }
  ]
)
```

### Event Types

```ruby
# List all event types
Paddle::EventType.list
```

### Events

```ruby
# List all events
# https://developer.paddle.com/api-reference/events/list-events
Paddle::Event.list
```

### Notification Settings

Used for creating webhook and email notifications

```ruby
# List all notification settings
Paddle::NotificationSetting.list

# Retrieve a notification setting
Paddle::NotificationSetting.retrieve(id: "ntfset_abc123")

# Create a notification setting
# https://developer.paddle.com/api-reference/notification-settings/create-notification-setting
Paddle::NotificationSetting.create(
  description: "Webhook for App",
  destination: "https://myapp.com/webhook",
  type: "webhook",
  subscribed_events: [
    "subscription.activated",
    "transaction.completed"
  ]
)

# Update a notification setting
# https://developer.paddle.com/api-reference/notification-settings/update-notification-setting
Paddle::NotificationSetting.update(id: "ntfset_abc123",
  subscribed_events: [
    "subscription.activated",
    "transaction.completed",
    "transaction.billed"
  ]
)

# Delete a notification setting
Paddle::NotificationSetting.delete(id: "ntfset_abc123")
```

### Notifications

```ruby
# List all notifications
Paddle::Notification.list
Paddle::Notification.list(notification_setting_id: "ntfset_abc123")
Paddle::Notification.list(status: "delivered")
Paddle::Notification.list(status: "failed")

# Retrieve a notification
Paddle::Notification.retrieve(id: "ntf_abc123")

# Replay a notification
# Attempts to resend a notification
# (currently not working)
Paddle::Notification.replay(id: "ntf_abc123")

# List all logs for a notification
# https://developer.paddle.com/api-reference/notifications/list-notification-logs
Paddle::Notification.logs(id: "ntf_abc123")
```


## Classic API

For accessing the Paddle Classic API

### Set Client Details

Firstly you'll need to set your Vendor ID, Vendor Auth Code and if you want
to use the Sandbox API or not.

You can find your vendor details [here for production](https://vendors.paddle.com/authentication),
or [here for sandbox](https://sandbox-vendors.paddle.com/authentication)

```ruby
@client = Paddle::Classic::Client.new(
  vendor_id: "",
  vendor_auth_code: "",
  # Use the sandbox version of the API
  sandbox: true
)
```

### Plans

```ruby
# Retrieves a list of Plans
@client.plans.list
```

### Subscription Users

```ruby
# List all users subscribed to any plan
@client.users.list
@client.users.list(subscription_id: "abc123")
@client.users.list(plan_id: "abc123")
@client.users.list(state: "active")
@client.users.list(state: "deleted")

# Update a user's subscription
# https://developer.paddle.com/api-reference/e3872343dfbba-update-user
@client.users.update(subscription_id: "abc123")

# Pause a user's subscription
@client.users.pause(subscription_id: "abc123")

# Unpause a user's subscription
@client.users.unpause(subscription_id: "abc123")

# Update the Postcode/ZIP Code of a user's subscription
@client.users.update_postcode(subscription_id: "abc123", postcode: "123abc")

# Cancel a user's subscription
@client.users.cancel(subscription_id: "abc123")
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/deanpcmad/paddle.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
