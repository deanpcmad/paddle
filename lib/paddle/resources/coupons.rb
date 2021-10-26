module Paddle
  class CouponsResource < Resource

    def list(product_id:)
      response = post_request("2.0/product/list_coupons", body: {product_id: product_id})
      Collection.from_response(response, type: Coupon)
    end

    def create(coupon_type:, discount_type:, discount_amount:, **params)
      attrs = {coupon_type: coupon_type, discount_type: discount_type, discount_amount: discount_amount}

       response = post_request("2.1/product/create_coupon", body: attrs.merge(params))

      coupons =  response.body["response"]["coupon_codes"]

      coupons.map {|c| Paddle::Coupon.new(code: c)}
    end

    def delete(coupon_code:, product_id:)
      attrs = {coupon_code: coupon_code, product_id: product_id}
      response = post_request("2.0/product/delete_coupon", body: attrs)
      return true if response.success?
    end

  end
end
