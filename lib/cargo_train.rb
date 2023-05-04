# frozen_string_literal: true

class CargoTrain < Train
  def initialize(number, wagons = [])
    @type = 'cargo'
    super
  end
end
