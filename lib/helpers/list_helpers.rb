# frozen_string_literal: true

# List helpers module description
module ListHelpers
  def routes_list
    @routes.each_with_index { |route, i| puts "Маршрут номер #{i}, #{route.route.inspect}" }
  end

  def trains_list
    @trains.each { |train| puts train.inspect }
  end

  def stations_list
    stations.each { |station| puts "Станция: #{station.name}, поезда на станции: #{station.trains}" }
  end

  def trains_on_station_list
    station = select_station
    station.trains.each { |train| puts train.inspect }
  end
end
