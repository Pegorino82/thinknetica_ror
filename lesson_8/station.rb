#   Класс Station (Станция):
#   Имеет название, которое указывается при ее создании
#   Может принимать поезда (по одному за раз)
#   Может возвращать список всех поездов на станции, находящиеся в текущий момент
#   Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
#   Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
require_relative 'instance_counter'

class Station
  include InstanceCounter
  attr_reader :name, :trains

  @@stations = []
  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations.push(self)
    validate!
  end

  def arrive_train(train)
    trains.push(train)
  end

  def depart_train(train)
    trains.delete(train)
  end

  def get_trains_by_type(train_type)
    trains.select { |train| train.train_type == train_type }
  end

  def each_train(&block)
    trains.each(&block)
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise TypeError, 'Station name must be string' unless name.instance_of? String
  end
end
