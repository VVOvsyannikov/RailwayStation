# frozen_string_literal: true

# Cargo train class
class CargoTrain < Train
  def initialize(number, wagons = [])
    @type = 'cargo'
    super
  end
end
