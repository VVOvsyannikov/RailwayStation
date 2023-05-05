# frozen_string_literal: true
require_relative 'company_name'

# Simple wagon class
class Wagon
  include CompanyName

  attr_reader :type
end
