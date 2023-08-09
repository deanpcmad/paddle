# frozen_string_literal: true

require "faraday"

require_relative "paddle/version"

module Paddle

  autoload :Configuration, "paddle/configuration"
  autoload :Client, "paddle/client"
  autoload :Collection, "paddle/collection"
  autoload :Error, "paddle/error"
  autoload :Object, "paddle/object"

  class << self
    attr_writer :config
  end

  def self.configure
    yield(config) if block_given?
  end

  def self.config
    @config ||= Paddle::Configuration.new
  end

  # Load Billing APIs
  autoload :Product, "paddle/models/product"
  autoload :Price, "paddle/models/price"
  autoload :Discount, "paddle/models/discount"
  autoload :Customer, "paddle/models/customer"
  autoload :Address, "paddle/models/address"
  autoload :Subscription, "paddle/models/subscription"

  # Load Classic APIs
  module Classic
    autoload :Client, "paddle/classic/client"
    autoload :Collection, "paddle/classic/collection"
    autoload :Resource, "paddle/classic/resource"

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
