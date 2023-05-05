module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
  end

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