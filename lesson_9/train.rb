#   Класс Train (Поезд):
#   Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов,
#   эти данные указываются при создании экземпляра класса
#   Может набирать скорость
#   Может возвращать текущую скорость
#   Может тормозить (сбрасывать скорость до нуля)
#   Может возвращать количество вагонов
#   Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает
#   или уменьшает количество вагонов).
#   Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
#   Может принимать маршрут следования (объект класса Route).
#   При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
#   Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад,
#   но только на 1 станцию за раз.
#   Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  include InstanceCounter
  include Manufacturer
  include Validation
  attr_reader :number, :speed, :wagons, :route
  validate :number, :format, /^[\w\d]{3}-?[\w\d]{2}$/

  @@trains = []

  def self.find(number)
    @@trains.detect { |train| train.number == number }
  end

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    @route = nil
    @current_station_index = nil
    @@trains.push(self)
    register_instance
    validate!
  end

  def speed_up(value)
    @speed += value
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    add_wagon!(wagon)
  end

  def del_wagon
    wagons.pop if speed.zero? && !wagons.empty?
  end

  def add_route(route)
    @route = route
    @current_station_index = 0
  end

  def move_forward
    @current_station_index += 1 if @current_station_index < route.stations.size
  end

  def move_backward
    @current_station_index -= 1 if @current_station_index.positive?
  end

  def current_station
    route.stations[@current_station_index]
  end

  def next_station
    route.stations[@current_station_index + 1]
  end

  def prev_station
    route.stations[@current_station_index - 1]
  end

  def each_wagon(&block)
    wagons.each(&block)
  end

  protected

  # пользователь не должен иметь возможности поменять тип поеза
  def type
    'unset'
  end

  # запрещаем прицеплять к поезду вагоны другого типа
  def add_wagon!(wagon)
    raise "Wagon must be #{type}." unless wagon.type == type

    wagons.push(wagon)
  end
end
