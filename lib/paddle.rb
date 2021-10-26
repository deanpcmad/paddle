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

  autoload :Plan, "paddle/objects/plan"
  autoload :Coupon, "paddle/objects/coupon"
  
end
