# frozen_string_literal: true

require "faraday"

require_relative "paddle/version"

module Paddle
  
  autoload :Client, "paddle/client"
  autoload :Collection, "paddle/collection"
  autoload :Error, "paddle/error"
  autoload :Resource, "paddle/resource"
  autoload :Object, "paddle/object"

  autoload :PlansResource, "paddle/resources/plans"
  autoload :CouponsResource, "paddle/resources/coupons"
  autoload :ProductsResource, "paddle/resources/products"
  autoload :LicensesResource, "paddle/resources/licenses"
  autoload :PayLinksResource, "paddle/resources/pay_links"
  autoload :TransactionsResource, "paddle/resources/transactions"
  autoload :PaymentsResource, "paddle/resources/payments"
  autoload :UsersResource, "paddle/resources/users"
  autoload :WebhooksResource, "paddle/resources/webhooks"
  autoload :ModifiersResource, "paddle/resources/modifiers"
  autoload :ChargesResource, "paddle/resources/charges"

  autoload :Plan, "paddle/objects/plan"
  autoload :Coupon, "paddle/objects/coupon"
  autoload :Product, "paddle/objects/product"
  autoload :License, "paddle/objects/license"
  autoload :PayLink, "paddle/objects/pay_link"
  autoload :Transaction, "paddle/objects/transaction"
  autoload :Payment, "paddle/objects/payment"
  autoload :PaymentRefund, "paddle/objects/payment_refund"
  autoload :User, "paddle/objects/user"
  autoload :Webhook, "paddle/objects/webhook"
  autoload :Modifier, "paddle/objects/modifier"
  autoload :Charge, "paddle/objects/charge"
  
end
