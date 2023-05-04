# frozen_string_literal: true

# Passenger train class
class PassengerTrain < Train
  def initialize(number, wagons = [])
    @type = 'passenger'
    super
  end
end
