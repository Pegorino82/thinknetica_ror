require_relative 'station'
require_relative 'route'
require_relative 'train'


station_1 = Station.new('first')
station_2 = Station.new('second')
station_3 = Station.new('third')
station_4 = Station.new('fourth')
station_5 = Station.new('fifth')
station_6 = Station.new('sixth')

route = Route.new(station_1, station_6)
route.add_station(station_2)
route.add_station(station_4)
route.add_station(station_5)

train = Train.new('123', 'pass', 5)


train.add_route(route)
puts train.get_current_station.name
train.move_backward
puts train.get_current_station.name
train.move_forward
puts train.get_current_station.name
puts train.train_size
train.add_wagon
puts train.train_size
train.speed_up(20)
train.add_wagon
puts train.train_size
puts train.get_current_station.name
puts train.get_prev_station.name
puts train.get_next_station.name
puts station_2.trains[0].number

