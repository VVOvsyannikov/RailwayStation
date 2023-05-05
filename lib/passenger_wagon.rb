# frozen_string_literal: true

# Passenger wagon class
class PassengerWagon < Wagon
  def initialize
    @type = 'passenger'
    super
  end
end
