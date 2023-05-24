# frozen_string_literal: true

# Company Name module description
module MainMenu
  MENU = "Выберите действие, которое хотите осуществить (введите число):\n" \
    "1. Создать новую станцию\n" \
    "2. Создать новый поезд\n" \
    "3. Создать маршрут \n" \
    "4. Добавить станцию к марштуру\n" \
    "5. Удалить станцию из маршрута\n" \
    "6. Назначить маршрут поезду \n" \
    "7. Добавить вагоны к поезду\n" \
    "8. Отцепить вагоны от поезда\n" \
    "9. Переместить поезд по маршруту\n" \
    "10. Посмотреть список станций\n" \
    "11. Просмотреть список поездов на станции\n" \
    "12. Просмотреть список маршрутов\n" \
    '0. Завершить программу'

  ACTIONS = {
    1 => :create_railway_station,
    2 => :create_train,
    3 => :create_route,
    4 => :add_station_to_route,
    5 => :delete_station_from_route,
    6 => :set_route_to_train,
    7 => :add_wagons,
    8 => :pop_wagons,
    9 => :set_train_to_station,
    10 => :stations_list,
    11 => :trains_on_station_list,
    12 => :routes_list,
    0 => :break_program
  }.freeze

  TYPES = {
    1 => 'cargo',
    2 => 'passenger'
  }.freeze
end
