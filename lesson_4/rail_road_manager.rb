require_relative 'rail_road'


class RailRoadManager
	STATION_ACTIONS = {
		'1' => ['create station', :create_station],
		'2' => ['show all stations', :show_all_stations],
		'3' => ['show station trains', :show_station_trains],		
		'0' => ['back', nil]
	}
	TRAIN_ACTIONS = {
		'1' => ['create train', :create_train],
		'2' => ['add route to train', :add_route_to_train],
		'3' => ['add wagon to train', :add_wagon_to_train],
		'4' => ['delete wagon from train', :del_wagon_from_train],
		'5' => ['move train forward', :move_train_forward],
		'6' => ['move train backward', :move_train_backward],
		'0' => ['back', nil]
	}
	ROUTE_ACTIONS = {
		'1' => ['create route', :create_route],
		'2' => ['add station to route', :add_station_to_route],
		'3' => ['del station from route', :del_station_from_route],
		'0' => ['back', nil]
	}
	CHOOSE_OBJECT = {
		'1' => ['station', STATION_ACTIONS],
		'2' => ['train', TRAIN_ACTIONS],
		'3' => ['route', ROUTE_ACTIONS],
		'0' => ['exit', nil]
	}

	def initialize
		@rail_road = RailRoad.new
	end

	def start
		loop do
			self.show_actions(CHOOSE_OBJECT)
			action = gets.chomp
			break if action == '0'
			self.sub_actions(CHOOSE_OBJECT[action].last, CHOOSE_OBJECT[action].first)
		end	
	end

	private

	def show_actions(actions, title = nil)
		text = "Type command"
		text += title ? " for #{title}:\n" : ":\n"
		actions.each_pair do |command, value|
			text += " - #{command} to #{value.first}\n"
		end
		puts text
	end

	def sub_actions(actions, title)
		loop do
			self.show_actions(actions, title)
			action = gets.chomp
			break if action == '0'
			send(actions[action].last)
		end
	end

	def create_station
		print "Enter station name: "
		name = gets.chomp
		station = @rail_road.create_station(name)
		puts "Station #{station.name} created" if station
	end

	def show_all_stations
		puts "No stations" if @rail_road.stations.size.zero?
		@rail_road.stations.each_key do |station|
			puts "Station #{station}"	
		end
	end

	def show_station_trains
		print "Enter station name: "
		name = gets.chomp
		trains = @rail_road.get_station_trains(name)
		if trains == nil
			puts "No station #{name}"
			return
		elsif trains.size.zero?
			puts "No trains on station #{name}"
			return
		end
		trains.each do |train|
			puts "Station #{name}: train #{train.number} (#{train.wagons.size} wagons)"
		end
	end

	def create_train
		while 1
			print "Enter train type ('p' - passenger, 'c' - cargo): "
			train_type = gets.chomp.downcase
			break if ['p', 'c'].include?(train_type)	
		end		 
		print "Enter train number: "
		train_number = gets.chomp
		train = @rail_road.create_train(train_type, train_number)
		puts "Train #{train.number} created" if train
	end

	def add_route_to_train
		print "Enter first station name: "
		first_station_name = gets.chomp
		print "Enter last station name: "
		last_station_name = gets.chomp
		print "Enter train number: "
		train_number = gets.chomp
		@rail_road.add_route_to_train(first_station_name, last_station_name, train_number)
	end

	def add_wagon_to_train
		while 1
			print "Enter wagon type ('p' - passenger, 'c' - cargo): "
			train_type = gets.chomp.downcase
			break if ['p', 'c'].include?(train_type)	
		end		 
		wagon = train_type == 'p' ? PassWagon.new('passenger') : CargoWagon.new('cargo')
		print "Enter train number: "
		train_number = gets.chomp
		@rail_road.add_wagon_to_train(wagon, train_number)
	end

	def del_wagon_from_train
		print "Enter train number: "
		train_number = gets.chomp
		@rail_road.del_wagon_from_train(train_number)
	end

	def move_train_forward
		print "Enter train number: "
		train_number = gets.chomp
		@rail_road.move_train_forward(train_number)
	end

	def move_train_backward
		print "Enter train number: "
		train_number = gets.chomp
		@rail_road.move_train_backward(train_number)
	end

	def create_route
		print "Enter first station name: "
		first_station_name = gets.chomp
		print "Enter last station name: "
		last_station_name = gets.chomp
		route = @rail_road.create_route(first_station_name, last_station_name)
		puts "Route #{route.stations.first} - #{route.stations.last} created" if route
	end

	def add_station_to_route
		print "Enter station name: "
		station_name = gets.chomp
		print "Enter first station name: "
		first_station_name = gets.chomp
		print "Enter last station name: "
		last_station_name = gets.chomp
		@rail_road.add_station_to_route(station_name, first_station_name, last_station_name)
	end

	def del_station_from_route
		print "Enter station name: "
		station_name = gets.chomp
		print "Enter first station name: "
		first_station_name = gets.chomp
		print "Enter last station name: "
		last_station_name = gets.chomp
		@rail_road.del_station_from_route(station_name, first_station_name, last_station_name)
	end
end

