require_relative 'station'
require_relative 'route'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'

passenger_train_1 = PassengerTrain.new('pas-01')
passenger_train_2 = PassengerTrain.new('pas-02')
cargo_train_1 = CargoTrain.new('car-01')
cargo_train_2 = CargoTrain.new('car-01')

passenger_train_1.add_wagon(PassengerWagon.new(20))
passenger_wagon = PassengerWagon.new(35)
passenger_wagon.take_seat
passenger_wagon.take_seat
passenger_wagon.take_seat
passenger_wagon.take_seat
passenger_train_1.add_wagon(passenger_wagon)
passenger_train_2.add_wagon(PassengerWagon.new(15))
passenger_train_2.add_wagon(PassengerWagon.new(25))
passenger_train_2.add_wagon(PassengerWagon.new(25))
passenger_train_2.add_wagon(PassengerWagon.new(25))

cargo_train_1.add_wagon(CargoWagon.new(500))
cargo_train_1.add_wagon(CargoWagon.new(500))
cargo_train_1.add_wagon(CargoWagon.new(500))
cargo_train_1.add_wagon(CargoWagon.new(500))

cargo_train_2.add_wagon(CargoWagon.new(500))
cargo_train_2.add_wagon(CargoWagon.new(500))
cargo_train_2.add_wagon(CargoWagon.new(500))
cargo_train_2.add_wagon(CargoWagon.new(500))

station = Station.new('First')

station.arrive_train(passenger_train_1)
station.arrive_train(cargo_train_1)
station.arrive_train(cargo_train_2)
station.arrive_train(passenger_train_2)

station.each_train do |train|
  puts "Train #{train.type} \##{train.number} wagons: #{train.wagons.size}"
  if train.type == 'passenger'
    number = 1
    train.each_wagon do |wagon|
      puts "\t\##{number} #{wagon.type} free seats: #{wagon.free_seats} taken seats: #{wagon.taken_seats}"
      number += 1
    end
  else
    number = 1
    train.each_wagon do |wagon|
      puts "\t\##{number} #{wagon.type} free volume: #{wagon.free_volume} taken volume: #{wagon.taken_volume}"
      number += 1
    end
  end
end
