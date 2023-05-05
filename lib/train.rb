# frozen_string_literal: true
require_relative 'company_name'

# Simple Train class
class Train
  include CompanyName
  include InstanceCounter

  attr_reader :wagons, :speed, :type, :number

  class << self
    def find(train_number)
      @trains.find { |train| train.number == train_number }
    end

    def trains
      @trains ||= []
    end
  end

  def initialize(number, wagons = [])
    @number = number
    @speed = 0
    @wagons = wagons
    collect_trains
    register_instance
  end

  def collect_trains
    self.class.trains << self
  end

  def accelerate
    @speed += 10
  end

  def brake
    @speed -= 10
    @speed = 0 if speed.negative?
  end

  def attach_wagon(wagon)
    return false if wagon.type != type

    @wagons << wagon if speed.zero?
  end

  def un_attach_wagon
    return false unless speed.zero?

    @wagons.pop
  end

  def wagons_count
    wagons.size
  end

  def current_station
    @route.nil? ? nil : @route[@station_index]
  end

  def next_station
    @station_index < @route.route.size ? @route.route[@station_index + 1] : nil
  end

  def previous_station
    @station_index.positive? ? @route.route[@station_index - 1] : nil
  end

  def go_to_next_station
    return false unless @station_index == @route.route.size - 1

    @station_index += 1
    @route.route[@station_index - 1].send_train(self)
    @route.route[@station_index].add_train(self)
  end

  def new_route(route)
    @route = route
    @station_index = 0
    @route.route[@station_index].add_train(self)
  end
end
