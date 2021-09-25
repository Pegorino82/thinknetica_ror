=begin
Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
	- Создавать станции
	- Создавать поезда
	- Создавать маршруты и управлять станциями в нем (добавлять, удалять)
	- Назначать маршрут поезду
	- Добавлять вагоны к поезду
	- Отцеплять вагоны от поезда
	- Перемещать поезд по маршруту вперед и назад
	- Просматривать список станций и список поездов на станции
=end
require_relative 'station'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'route'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'


class RailRoadManager
	STATION_ACTIONS = [
		{command: '1', title: 'create station', action: :create_station},
		{command: '2', title: 'show all stations', action: :show_all_stations},
		{command: '3', title: 'show station trains', action: :show_station_trains},
		{command: '0', title: 'back'}
	]
	TRAIN_ACTIONS = [
		{command: '1', title: 'create train', action: :create_train},
		{command: '2', title: 'show wagons', action: :show_train_wagons},
		{command: '3', title: 'add route to train', action: :add_route_to_train},
		{command: '4', title: 'add wagon to train', action: :add_wagon_to_train},
		{command: '5', title: 'delete wagon from train', action: :del_wagon_from_train},
		{command: '6', title: 'move train forward', action: :move_train_forward},
		{command: '7', title: 'move train backward', action: :move_train_backward},
		{command: '0', title: 'back'},
	]
	ROUTE_ACTIONS = [
		{command: '1', title: 'create route', action: :create_route},
		{command: '2', title: 'add station to route', action: :add_station_to_route},
		{command: '3', title: 'del station from route', action: :del_station_from_route},
		{command: '0', title: 'back'},
	]
	CHOOSE_OBJECT = [
		{command: '1', title: 'station', object: STATION_ACTIONS},
		{command: '2', title: 'train', object: TRAIN_ACTIONS},
		{command: '3', title: 'route', object: ROUTE_ACTIONS},
		{command: '0', title: 'exit'},
	]

	def initialize
		@stations = []
		@trains = []
		@routes = []
	end

	def start
		loop do
			self.show_actions(CHOOSE_OBJECT)
			action = gets.chomp.to_i
			break if action == 0
			self.sub_actions(CHOOSE_OBJECT[action - 1][:object], CHOOSE_OBJECT[action - 1][:title])
		end
	end

	private

	def show_actions(actions, title = nil)
		text = "Type command"
		text += title ? " for #{title}:\n" : ":\n"
		actions.each do |action|
			text += " - #{action[:command]} to #{action[:title]}\n"
		end
		puts text
	end

	def sub_actions(actions, title)
		loop do
			self.show_actions(actions, title)
			action = gets.chomp.to_i
			break if action == 0
			send(actions[action -1][:action])
		end
	end

	def create_station
		print "Enter station name: "
		name = gets.chomp

		station = Station.new(name)
		@stations.push(station)

		puts "Station #{station.name} created" if station
	end

	def show_all_stations
		puts "No stations" if @stations.size.zero?
		@stations.each do |station|
			puts "Station #{station.name}"
		end
	end

	def show_station_trains
		print "Enter station name: "
		name = gets.chomp

		station = self.get_station(name)
		if !station
			puts "No station #{name}"
			return
		end
		if station.trains.size.zero?
			puts "No trains on station #{name}"
			return
		end
		station.each_train { |train| puts "Train #{train.type} \##{train.number} wagons: #{train.wagons.size}" }
  end

  def create_train
    train_type_attempt = 0
    train_number_attempt = 0
    begin
			print "Enter train type ('p' - passenger, 'c' - cargo): "
      train_type = gets.chomp.downcase
      validate_train_type_input! train_type
    rescue => e
      train_type_attempt += 1
      puts train_type_attempt < 5 ? "Enter valid data: #{e.message}" : "You failed after #{train_type_attempt} attempts."
      retry if train_type_attempt < 5
      return
    end

    begin
      print "Enter train number: "
      train_number = gets.chomp
      train = train_type == 'p' ? PassengerTrain.new(train_number) : CargoTrain.new(train_number)
    rescue => e
      train_number_attempt += 1
      puts train_number_attempt < 5 ? "Enter valid data: #{e.message}" : "You failed after #{train_number_attempt} attempts."
      retry if train_number_attempt < 5
    else
      @trains.push(train)
      puts "Train #{train.number} created" if train
    end
	end

	def show_train_wagons
		print "Enter train number: "
		train_number = gets.chomp

		train = self.get_train(train_number)
		return if !train

		number = 1
		train.each_wagon do |wagon|
			puts "\t\##{number} #{wagon.type} free #{wagon.class::UNITS}: #{wagon.free_place} taken #{wagon.class::UNITS}: #{wagon.used_place}"
		end
	end

	def add_route_to_train
		print "Enter first station name: "
		first_station_name = gets.chomp
		print "Enter last station name: "
		last_station_name = gets.chomp
		print "Enter train number: "
		train_number = gets.chomp

		route = self.get_route(first_station_name, last_station_name)
		train = self.get_train(train_number)
		return if !route || !train

		train.add_route(route)
		self.get_station(first_station_name).arrive_train(train)

		puts "Route #{route.stations.first.name} - #{route.stations.last.name} added to train #{train.number}"
	end

	def create_wagon
		while 1
			print "Enter wagon type ('p' - passenger, 'c' - cargo): "
			wagon_type = gets.chomp.downcase
			break if ['p', 'c'].include?(wagon_type)
		end
		if wagon_type == 'p'
			print "Enter total seats: "
			total_seats = gets.chomp.to_i
			wagon = PassengerWagon.new(total_seats)
		else
			print "Enter total volume: "
			total_volume = gets.chomp.to_i
			wagon = CargoWagon.new(total_volume)
		end
		return wagon
	end

	def take_seat(wagon)
		wagon.take_seat
	end

	def add_volume(wagon, volume)
		wagon.add_volume(volume)
	end

	def fill_wagon(wagon)
		loop do
			print "Do you want to #{wagon.type == 'cargo' ? 'add' : 'take'} #{wagon.class::UNITS} (y/<any>)?"
			to_add = gets.chomp
			if to_add == 'y' && wagon.type == 'passenger'
				wagon.take_seat
			elsif to_add == 'y' && wagon.type == 'cargo'
				print "Enter volume to add: "
				volume = gets.chomp.to_i
				wagon.add_volume(volume)
			else
				break
			end
		end
	end

	def add_wagon_to_train
		print "Enter train number: "
		train_number = gets.chomp

		train = self.get_train(train_number)
		return if !train

		attempt = 0
		begin
			wagon = create_wagon
			fill_wagon(wagon)
			train.add_wagon(wagon)
			puts "Add #{wagon.type} wagon to train #{train.number}"
		rescue => e
			attempt += 1
			puts e
			retry if attempt < 5
			return
		end
	end

	def del_wagon_from_train
		print "Enter train number: "
		train_number = gets.chomp

		self.get_train(train_number).del_wagon

		puts "Delete wagon from train #{train.number}"
	end

	def move_train_forward
		print "Enter train number: "
		train_number = gets.chomp

		train = self.get_train(train_number)
		return if !train || !train.route
		train.move_forward
		prev_station = train.get_prev_station
		prev_station.depart_train(train)
		current_station = train.get_current_station
		current_station.arrive_train(train)

		puts "Train #{train.number} moved to #{current_station.name} from #{prev_station.name}"
	end

	def move_train_backward
		print "Enter train number: "
		train_number = gets.chomp

		train = self.get_train(train_number)
		return if !train || !train.route
		train.move_backward
		next_station = train.get_next_station
		next_station.depart_train(train)
		current_station = train.get_current_station
		current_station.arrive_train(train)

		puts "Train #{train.number} moved to #{current_station.name} from #{next_station.name}"
	end

	def create_route
		print "Enter first station name: "
		first_station_name = gets.chomp
		print "Enter last station name: "
		last_station_name = gets.chomp

		first_station = self.get_station(first_station_name)
		last_station = self.get_station(last_station_name)
		route = Route.new(first_station, last_station)
		@routes.push(route)
		puts "Route #{route.stations.first.name} - #{route.stations.last.name} created" if route
	end

	def add_station_to_route
		print "Enter station name: "
		station_name = gets.chomp
		print "Enter first station name: "
		first_station_name = gets.chomp
		print "Enter last station name: "
		last_station_name = gets.chomp

		route = self.get_route(first_station_name, last_station_name)
		station = self.get_station(station_name)
		return if !route || !station
		route.add_station(station)

		puts "Station #{station.name} added to route  #{route.stations.first} - #{route.stations.last}"
	end

	def del_station_from_route
		print "Enter station name: "
		station_name = gets.chomp
		print "Enter first station name: "
		first_station_name = gets.chomp
		print "Enter last station name: "
		last_station_name = gets.chomp

		route = self.get_route(first_station_name, last_station_name)
		station = self.get_station(station_name)
		return if !route || !station
		route.del_station(station)

		puts "Station #{station.name} deleted from route  #{route.stations.first} - #{route.stations.last}"
	end

	def get_station(name)
		@stations.select {|station| station.name == name}.first
	end

	def get_train(number)
		@trains.select {|train| train.number == number}.first
	end

	def get_route(first_station_name, last_station_name)
		@routes.select {|route| (route.stations.first.name == first_station_name && route.stations.last.name == last_station_name)}.first
  end

  protected

  def validate_train_type_input! (type)
    raise "Train type must be Passenger or Cargo." if !['p', 'c'].include?(type)
  end
end


RailRoadManager.new.start
