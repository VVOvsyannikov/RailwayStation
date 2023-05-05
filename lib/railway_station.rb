# frozen_string_literal: true

# Simple Station class
class RailwayStation
  attr_reader :name, :trains

  class << self
    def instances
      @instances ||= []
    end

    def all
      instances
    end
  end

  def initialize(name)
    @name = name
    @trains = []
    add_instances
  end

  def add_instances
    self.class.instances << self
  end

  def add_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end
end
