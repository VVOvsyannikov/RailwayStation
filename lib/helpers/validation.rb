# frozen_string_literal: true

# Custom validation module
module Validation
  def self.included(base)
    base.extend ClassMethods
  end

  def validate!
    self.class.validations.each do |validation|
      self.class.send(validation[:type], validation[:name], self, validation[:args])
    end
  end

  def valid?
    return true if validate!

    false
  end

  # methods includes to Classes implementation
  module ClassMethods
    def validate(name, type, *args)
      raise TypeError, "#{name} is not symbol" unless name.is_a?(Symbol)
      raise TypeError, "#{type} is not symbol" unless type.is_a?(Symbol)
      raise TypeError, 'invalid validation type' unless %i[presence format type].include?(type)

      validations << {
        name:,
        type:,
        args:
      }
    end

    def validations
      @validations ||= []
    end

    private

    def presence(name, obj, _args)
      variable = obj.instance_variable_get("@#{name}")
      raise StandardError, 'Имя отсутствует' if variable.nil?
    end

    def format(name, obj, args)
      variable = obj.instance_variable_get("@#{name}")
      raise StandardError, "Не соответствует формат @#{name}" unless variable =~ args.first
    end

    def type(name, obj, args)
      variable = obj.instance_variable_get("@#{name}")
      variable.is_a?(args.first)
    end
  end
end
