# frozen_string_literal: true

require "faraday"

require_relative "paddle/version"

module Paddle

  autoload :Client, "paddle/client"
  autoload :Collection, "paddle/collection"
  autoload :Error, "paddle/error"
  autoload :Resource, "paddle/resource"
  autoload :Object, "paddle/object"

  # Load Classic API
  module Classic
    autoload :PlansResource, "paddle/classic/resources/plans"
    autoload :CouponsResource, "paddle/classic/resources/coupons"
    autoload :ProductsResource, "paddle/classic/resources/products"
    autoload :LicensesResource, "paddle/classic/resources/licenses"
    autoload :PayLinksResource, "paddle/classic/resources/pay_links"
    autoload :TransactionsResource, "paddle/classic/resources/transactions"
    autoload :PaymentsResource, "paddle/classic/resources/payments"
    autoload :UsersResource, "paddle/classic/resources/users"
    autoload :WebhooksResource, "paddle/classic/resources/webhooks"
    autoload :ModifiersResource, "paddle/classic/resources/modifiers"
    autoload :ChargesResource, "paddle/classic/resources/charges"

    autoload :Plan, "paddle/classic/objects/plan"
    autoload :Coupon, "paddle/classic/objects/coupon"
    autoload :Product, "paddle/classic/objects/product"
    autoload :License, "paddle/classic/objects/license"
    autoload :PayLink, "paddle/classic/objects/pay_link"
    autoload :Transaction, "paddle/classic/objects/transaction"
    autoload :Payment, "paddle/classic/objects/payment"
    autoload :PaymentRefund, "paddle/classic/objects/payment_refund"
    autoload :User, "paddle/classic/objects/user"
    autoload :Webhook, "paddle/classic/objects/webhook"
    autoload :Modifier, "paddle/classic/objects/modifier"
    autoload :Charge, "paddle/classic/objects/charge"
  end

end
