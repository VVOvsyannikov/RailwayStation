# frozen_string_literal: true

class CargoWagon < Wagon
  def initialize
    @type = 'cargo'
    super
  end
end
