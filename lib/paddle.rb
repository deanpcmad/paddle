# frozen_string_literal: true

require "faraday"
require "faraday_middleware"

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

  autoload :Plan, "paddle/objects/plan"
  autoload :Coupon, "paddle/objects/coupon"
  autoload :Product, "paddle/objects/product"
  autoload :License, "paddle/objects/license"
  autoload :PayLink, "paddle/objects/pay_link"
  autoload :Transaction, "paddle/objects/transaction"
  
end
