# frozen_string_literal: true

# Simple Route class
class Route
  attr_reader :route, :name

  NAME_FORMAT = /^[а-яa-z]{3}$/i

  def initialize(name, first_station, final_station)
    @first_station = first_station
    @final_station = final_station
    @name = name

    validate!
    @route = [@first_station, @final_station]
  end

  def valid?
    validate!
  rescue StandardError
    false
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

  private

  def validate!
    if !@first_station.is_a?(RailwayStation) || !@final_station.is_a?(RailwayStation)
      raise StandardError,
            'Станция должна быть объектом Железнодорожная станция'
    end

    raise StandardError, 'Ошибка! формат названия маршрута: три буквы' if name !~ NAME_FORMAT

    true
  end
end
