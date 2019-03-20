module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  class WrongTypeError < StandardError
    def message
      'Type of attribute is wrong.'
    end
  end

  module ClassMethods
    def attr_accessor_with_history(*attrs)
      attrs.each do |attr|
        attr_reader attr.to_sym, "#{attr}_history".to_sym
        define_method "#{attr}=" do |value|
          instance_variable_set("@#{attr}", value)
          update_history(attr, value)
        end
        define_method "#{attr}_history" do
          instance_variable_get("@#{attr}_history")
        end
      end
    end

    def strong_attr_accessor(attr, klass)
      attr_reader attr.to_sym
      define_method "#{attr}=" do |value|
        return instance_variable_set("@#{attr}", value) if klass == value.class

        raise WrongTypeError
      end
    end
  end

  module InstanceMethods
    private

    def update_history(attr, value)
      history = instance_variable_get("@#{attr}_history") || []
      instance_variable_set("@#{attr}_history", history << value)
    end
  end
end
