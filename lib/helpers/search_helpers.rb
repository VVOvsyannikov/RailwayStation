# frozen_string_literal: true

# Search helpers module description
module SearchHelpers
  def search_train(number)
    @trains.find { |train| train.number == number }
  end

  def search_station(station_name)
    @stations.find { |station| station.name == station_name }
  end

  def search_route(name)
    @routes.select { |route| route.name.eql? name }
  end
end
