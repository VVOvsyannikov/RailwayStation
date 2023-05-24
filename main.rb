# frozen_string_literal: true

require_relative 'lib/route'
require_relative 'lib/instance_counter'
require_relative 'lib/train'
require_relative 'lib/wagon'
require_relative 'lib/cargo_train'
require_relative 'lib/cargo_wagon'
require_relative 'lib/company_name'
require_relative 'lib/main_menu'
require_relative 'lib/passenger_train'
require_relative 'lib/passenger_wagon'
require_relative 'lib/railway_station'
require_relative 'lib/helpers/list_helpers'
require_relative 'lib/helpers/search_helpers'
require_relative 'lib/helpers/select_helpers'

# User interface class
class Main
  include MainMenu
  include ListHelpers
  include SearchHelpers
  include SelectHelpers

  attr_reader :stations

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def start
    loop do
      input = user_input(MENU).to_i

      if input.to_s !~ /^([0-9]|1[0-2])$/
        puts "Ошибка: Введён неверный номер действия\n "
        next
      end

      send ACTIONS[input]
    end
  end

  private

  def user_input(message)
    puts message
    gets.chomp
  end

  def create_railway_station
    name = user_input('Введите имя станции (буквы, цифры, пробел):').to_s

    @stations << RailwayStation.new(name)
  rescue StandardError => e
    puts e.message
    retry
  end

  def create_train
    number = user_input('Введите номер поезда:').to_s
    type = user_input('Выберите тип поезда (1. Грузовой, 2. Пассажирский):').to_i

    class_name = "#{TYPES[type].capitalize}Train"
    @trains << Object.const_get(class_name).new(number)
  rescue StandardError => e
    puts e.message
    retry
  end

  def create_route
    return puts 'Список станций пустой' if stations.empty?

    name = user_input("Введите название маршрута:\n").to_s
    stations_list
    first_station = search_station(user_input("Введите название начальной станции:\n").to_s)
    final_station = search_station(user_input("Введите название конечной станции:\n").to_s)

    @routes << Route.new(name, first_station, final_station)
  rescue StandardError => e
    puts e.message
    retry
  end

  def add_station_to_route
    route = select_route
    station = select_station
    raise StandardError, 'Такая станция уже есть в маршруте' if route.route.include? station

    route.add_station(station)
  rescue StandardError => e
    puts e.message
    retry
  end

  def delete_station_from_route
    route = select_route
    station = select_station

    route.remove_station(station)
  end

  def set_route_to_train
    route = select_route
    train = select_train

    train.new_route(route)
  rescue StandardError => e
    puts e.message
    retry
  end

  def add_wagons
    number = user_input("Введите номер поезда, к которому нужно прицепить вагоны (3 цифры):\n#{@trains.inspect}").to_s

    train = search_train(number)

    class_name = "#{train.type.capitalize}Wagon"

    wagon = Object.const_get(class_name).new

    train.attach_wagon(wagon)
  rescue StandardError => e
    puts e.message
    retry
  end

  def pop_wagons
    number = user_input("Введите номер поезда, от которого нужно отцепить вагоны (3 цифры):\n#{@trains.inspect}").to_s

    train = search_train(number)

    train.un_attach_wagon
  end

  def set_train_to_station
    number = user_input("Введите номер поезда, который вы хотите переместить:\n#{@trains.inspect}").to_s

    station_name = user_input("Выберите название станции, куда выхотите переместить поезд:\n#{@stations.inspect}").to_s

    train = search_train(number)
    station = search_station(station_name)

    station.add_train(train)
  end

  def break_program
    exit
  end
end

game = Main.new
game.start
