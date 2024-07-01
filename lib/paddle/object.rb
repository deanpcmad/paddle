require "ostruct"

module Paddle
  class Object < OpenStruct
    def initialize(attributes)
      super to_ostruct(attributes)
    end

    def to_ostruct(obj)
      if obj.is_a?(Hash)
        OpenStruct.new(obj.map { |key, val| [ key, to_ostruct(val) ] }.to_h)
      elsif obj.is_a?(Array)
        obj.map { |o| to_ostruct(o) }
      else # Assumed to be a primitive value
        obj
      end
    end

    def update(**params)
      method_missing :update unless klass.respond_to? :update

      primary_attributes = klass.method(:update).parameters.select { |(type, name)| type == :keyreq }.map(&:last) # Identified by whatever is a required named parameter.

      primary_attributes.each do |attrib|
        # ? Should we need to handle blank strings here?
        params[attrib] = self[attrib] || self["#{attrib}_id"] # Handling for customer (customer_id) and id.
      end

      klass.public_send(:update, **params).each_pair { |key, val| self[key] = val } # Updating self

      self
    end

    private

    def klass
      self.class
    end
  end
end
