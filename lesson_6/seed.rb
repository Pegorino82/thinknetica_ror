require_relative 'station'
require_relative 'route'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'

begin
  Station.new(123)
rescue TypeError => e
  puts "Station error #{e.inspect}"
  st = Station.new('123')
  puts "Station ok #{st}"
end

begin
  Train.new('456')
rescue => e
  puts "Train error #{e.inspect}"
  tp1 = PassengerTrain.new('999-AB')
  puts "Train ok #{tp1}"
end


tp1 = PassengerTrain.new('999-AB')
begin
 tp1.add_wagon(CargoWagon.new)
rescue => e
  puts "Train error #{e.inspect}"
  tp1.add_wagon(PassengerWagon.new)
  puts "Train ok #{tp1.wagons}"
end

begin
  Route.new('asd', 456)
rescue => e
  puts "Route error #{e.inspect}"
  route = Route.new(Station.new('asd'), Station.new('fgh'))
  puts "Route ok #{route.stations}"
end
