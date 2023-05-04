# frozen_string_literal: true

# Cargo wagon class
class CargoWagon < Wagon
  def initialize
    @type = 'cargo'
    super
  end
end
