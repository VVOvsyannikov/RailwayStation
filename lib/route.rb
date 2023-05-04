# frozen_string_literal: true

# Simple Route class
class Route
  attr_reader :route

  def initialize(first_station, final_station)
    raise 'Станция должна быть строкой' if !first_station.is_a?(RailwayStation) || !final_station.is_a?(RailwayStation)

    @route = [first_station, final_station]
  end

  def add_station(station)
    route.insert(-2, station)
  end

  def remove_station(station)
    route.delete(station)
  end

  def stations_list
    route.each { |station| puts station.inspect }
  end
end
