# frozen_string_literal: true

# counter of instances method implementation
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
  end

  # methods includes to Classes implementation
  module ClassMethods
    attr_writer :instances

    def instances
      @instances ||= 0
    end
  end

  private

  def register_instance
    self.class.instances += 1
  end
end
