# frozen_string_literal: true

# Custom metaprogramming accessors
module CustomAccessor
  def attr_accessor_with_history(*methods)
    options = methods.last.is_a?(Hash) ? methods.pop : {}

    methods.each do |method|
      raise TypeError, 'method name is not symbol' unless method.is_a?(Symbol)

      define_method(method) do
        instance_variable_get("@#{method}") ||
          instance_variable_set("@#{method}", options[:default])
      end

      define_method("#{method}=") do |value|
        instance_variable_set("@#{method}", value)
        instance_variable_set("@#{method}_history", send("#{method}_history").push(value))
      end

      define_method("#{method}_history") do
        instance_variable_get("@#{method}_history") ||
          instance_variable_set("@#{method}_history", [])
      end
    end
  end

  def strong_attr_acessor(accessor_name, accessor_class)
    define_method(accessor_name) do
      instance_variable_get("@#{accessor_name}")
    end

    define_method("#{accessor_name}=") do |value|
      raise TypeError, "value is not a #{accessor_class}" unless value.is_a?(accessor_class)

      instance_variable_set("@#{accessor_name}", value)
    end
  end
end
