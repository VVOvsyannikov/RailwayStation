# frozen_string_literal: true

require_relative 'lib/railway_station'
require_relative 'lib/train'
require_relative 'lib/cargo_train'
require_relative 'lib/passenger_train'
require_relative 'lib/wagon'
require_relative 'lib/cargo_wagon'
require_relative 'lib/passenger_wagon'
require_relative 'lib/route'

# User interface class
class Main
  attr_reader :stations

  def initialize
    @stations = []
    @trains = []
  end

  MENU = "Выберите действие, которое хотите осуществить (введите число):\n" \
      "1. Создать новую станцию\n" \
      "2. Создать новый поезд\n" \
      "3. Добавить вагоны к поезду\n" \
      "4. Отцепить вагоны от поезда\n" \
      "5. Переместить поезд на станцию\n" \
      "6. Просмотреть список станций и список поездов на станции\n" \
      '7. Завершить программу'

  ACTIONS = {
    1 => :add_new_railway_station,
    2 => :create_new_train,
    3 => :add_wagons,
    4 => :pop_wagons,
    5 => :set_train_to_station,
    6 => :stations_list,
    7 => :break_program
  }.freeze

  TYPES = {
    1 => 'cargo',
    2 => 'passenger'
  }.freeze

  def start
    loop do
      puts MENU

      input = gets.chomp.to_i

      send ACTIONS[input]
    end
  end

  private

  def add_new_railway_station
    system('clear')
    puts 'Введите имя станции:'
    name = gets.chomp.to_s

    @stations << RailwayStation.new(name)
    system('clear')
  end

  def create_new_train
    system('clear')

    puts 'Введите номер поезда (3 цифры):'

    number = gets.chomp.to_s

    puts 'Выберите тип поезда (1. Грузовой, 2. Пассажирский):'

    type = gets.chomp.to_i

    class_name = "#{TYPES[type].capitalize}Train"

    @trains << Object.const_get(class_name).new(number)
  end

  def add_wagons
    system('clear')

    puts 'Введите номер поезда, к которому нужно прицепить вагоны (3 цифры):'
    puts @trains.inspect

    number = gets.chomp.to_s

    train = search_train(number)

    type = train.type

    class_name = "#{type.capitalize}Wagon"

    wagon = Object.const_get(class_name).new

    train.attach_wagon(wagon)
  end

  def pop_wagons
    system('clear')

    puts 'Введите номер поезда, от которого нужно отцепить вагоны (3 цифры):'
    puts @trains.inspect

    number = gets.chomp.to_s

    train = search_train(number)

    train.un_attach_wagon
  end

  def set_train_to_station
    system('clear')
    puts 'Введите номер поезда, который вы хотите переместить на станцию (3 цифры):'
    puts @trains.inspect

    number = gets.chomp.to_s

    puts 'Выберите название станции, на которую выхотите переместить поезд:'
    puts @stations.inspect

    station_name = gets.chomp.to_s

    train = search_train(number)
    station = search_station(station_name)

    station.add_train(train)
  end

  def stations_list
    system('clear')
    stations.each do |station|
      puts station.inspect
      cargo_trains = station.trains_by_type('cargo')
      passenger_trains = station.trains_by_type('passenger')

      puts "Грузовые поезда: #{cargo_trains.inspect}" if cargo_trains.any?
      puts "Пассажирские поезда: #{passenger_trains.inspect}" if passenger_trains.any?
    end
  end

  def search_train(number)
    @trains.find { |train| train.number == number }
  end

  def search_station(station_name)
    @stations.find { |station| station.name == station_name }
  end

  def break_program
    exit
  end
end

game = Main.new
game.start
