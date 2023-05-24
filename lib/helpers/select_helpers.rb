# frozen_string_literal: true

# Select helpers module description
module SelectHelpers
  def select_station
    stations_list
    search_station(user_input('Выберите станцию:').to_s)
  end

  def select_route
    return puts 'Список маршрутов пустой' if @routes.empty?

    @routes.each { |route| puts "Маршрут: #{route.name}" }

    route = search_route(user_input('Выберите имя маршрута:').to_s).first

    raise StandardError, 'Нет такого маршрута' if route.nil?

    route
  end

  def select_train
    return puts 'Список поездов пустой' if @trains.empty?

    @trains.each { |train| puts "Поезд: #{train.number}" }

    train = search_train(user_input('Выберите номер поезда:').to_s)

    raise StandardError, 'Нет такого поезда' if train.nil?

    train
  end
end
