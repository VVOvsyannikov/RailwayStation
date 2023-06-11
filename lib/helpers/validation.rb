# frozen_string_literal: true

# Custom validation module
module Validation
  def self.included(base)
    base.extend ClassMethods
  end

  def validate!(obj)
    self.class.validations.each do |validation|
      puts "start :#{validation[:type]} validation"
      self.class.send(validation[:type], validation[:name], obj, validation[:args])
    end
  end

  def valid?
    return true if validate!(self)

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

      true
    end

    def format(name, obj, args)
      variable = obj.instance_variable_get("@#{name}")
      raise StandardError, "Не соответствует формат @#{name}" unless variable =~ args.first

      false
    end

    def type(name, obj, args)
      variable = obj.instance_variable_get("@#{name}")
      variable.is_a?(args.first)
    end
  end
end
