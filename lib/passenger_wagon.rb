# frozen_string_literal: true

class PassengerWagon < Wagon
  def initialize
    @type = 'passenger'
    super
  end
end
