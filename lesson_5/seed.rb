require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'

t1 = Train.new('456')
t2 = Train.new('79')
t2.manufacturer = 'cool factory'
puts t2.manufacturer


puts Train.instances
puts PassengerTrain.instances
puts CargoTrain.instances

tp1 = PassengerTrain.new('999')
puts PassengerTrain.instances
puts Train.instances
puts Train.find('999')
