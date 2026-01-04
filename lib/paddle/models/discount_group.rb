module Paddle
  class DiscountGroup < Object
    class << self
      def list(**params)
        response = Client.get_request("discount-groups", params: params)
        Collection.from_response(response, type: DiscountGroup)
      end

      def create(name:, **params)
        attrs = { name: name }
        response = Client.post_request("discount-groups", body: attrs.merge(params))
        DiscountGroup.new(response.body["data"])
      end

      def retrieve(id:)
        response = Client.get_request("discount-groups/#{id}")
        DiscountGroup.new(response.body["data"])
      end

      def update(id:, **params)
        response = Client.patch_request("discount-groups/#{id}", body: params)
        DiscountGroup.new(response.body["data"])
      end
    end

    def create_discount(**params)
      Discount.create(discount_group_id: id, **params)
    end

    def discounts(**params)
      Discount.list(discount_group_id: id, **params)
    end
  end
end
