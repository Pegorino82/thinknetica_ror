require_relative 'rail_road'

rr = RailRoad.new

print rr.methods

puts rr.create_station('station 1')
puts rr.create_station('station 2')
puts rr.create_station('station 3')

puts rr.create_train('c', 'train 1')
puts rr.create_train('p', 'train 2')
puts rr.create_train('c', 'train 1')

rr.create_route('station 1', 'station 2')
rr.create_route('station 1', 'station 2')
rr.create_route('station 1', 'station 3')

rr.add_station_to_route('station 3', 'station 1', 'station 2')

rr.add_route_to_train('station 1', 'station 2', 'train 2')

rr.move_train_forward('train 2')

puts "=======stations========="
puts rr.stations
puts rr.get_station_trains('station 1')
puts rr.get_station_trains('station 2')
puts "=======trains========="
puts rr.trains
puts "=======routes========="
puts rr.routes
