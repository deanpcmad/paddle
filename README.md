# PaddleRB

PaddleRB is a Ruby library for interacting with the Paddle APIs, both Classic and Billing.

**This library is currently under development for Paddle's new Billing APIs**

## Installation

Add this line to your application's Gemfile:

```ruby
gem "paddlerb"
```

## Billing API

For accessing the new Billing API from Paddle.

I've designed this library to be similar to Stripe.

### Set Client Details

Firstly you'll need to set your API Key and if you want
to use the Sandbox API or not.

You can find your vendor details [here for production](https://vendors.paddle.com/authentication),
or [here for sandbox](https://sandbox-vendors.paddle.com/authentication)

```ruby
@client = Paddle::Client.new(
  api_key: "abc123",
  # Use the sandbox version of the API
  sandbox: true
)
```

### Products

```ruby
# List all products
# https://developer.paddle.com/api-reference/products/list-products
@client.products.list
@client.products.list({status: "active"})
@client.products.list({tax_category: "saas"})

# Create a product
# https://developer.paddle.com/api-reference/products/create-product
@client.products.create({name: "My SAAS Plan", tax_category: "saas"})

# Retrieve a product
@client.products.retrieve "pro_abc123"

# Update a product
# https://developer.paddle.com/api-reference/products/update-product
@client.products.update("pro_abc123", {description: "This is a plan"})
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

Bug reports and pull requests are welcome on GitHub at https://github.com/deanpcmad/paddlerb.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
