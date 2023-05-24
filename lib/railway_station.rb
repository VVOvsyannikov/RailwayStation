# frozen_string_literal: true

# Simple Station class
class RailwayStation
  attr_reader :name, :trains

  class << self
    def instances
      @instances ||= []
    end

    def all
      instances
    end
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    add_instances
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def add_instances
    self.class.instances << self
  end

  def add_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end

  private

  def validate!
    raise StandardError, 'Название станции не может быть пустой строкой' if name.eql? ''
    raise StandardError, 'Название станции не может содержать только пробелы' unless name !~ /^\s*$/
    raise StandardError, 'Название станции должено содержать только буквы, цифры, пробел' if name !~ /^[a-za-я0-9\s]*$/i
    raise StandardError, 'Название станции не может заканчиваться или начинаться с пробела' unless name !~ /^\s|\s$/

    true
  end
end
