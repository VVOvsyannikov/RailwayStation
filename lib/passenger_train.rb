# frozen_string_literal: true

class PassengerTrain < Train
  def initialize(number, wagons = [])
    @type = 'passenger'
    super
  end
end
