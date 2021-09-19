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
require_relative 'pass_train'
require_relative 'cargo_train'
require_relative 'route'
require_relative 'pass_wagon'
require_relative 'cargo_wagon'


class RailRoad
	attr_reader :stations, :trains, :routes
	def initialize
		@stations = {} # <name>: <station>
		@trains = {} # <number>: <train>
		@routes = {} # <first_station_name>: {<last_station_name>: <route>}
	end

	def create_station(name)
		self.stations[name] = !self.stations.has_key?(name) ? Station.new(name) : self.stations[name]
	end

	def create_train(type, number)
		return self.trains[number] if self.trains.has_key?(number)
		train = type == 'c' ? PassTrain.new(number) : CargoTrain.new(number)
		self.trains[number] = train
	end

	def create_route(first_station_name, last_station_name)
		stored_route = self.get_route(first_station_name, last_station_name)
		return stored_route if stored_route
		self.routes[first_station_name] = {} if !self.routes[first_station_name]
		route = Route.new(self.stations[first_station_name], self.stations[last_station_name])	
		self.routes[first_station_name][last_station_name] = route
	end

	def add_station_to_route(station_name, first_station_name, last_station_name)
		route = self.get_route(first_station_name, last_station_name)
		station = self.get_station(station_name)
		return if !route || !station
		route.add_station(station)
	end

	def del_station_from_route(station_name, first_station_name, last_station_name)
		route = self.get_route(first_station_name, last_station_name)
		station = self.get_station(station_name)
		return if !route || !station
		route.del_station(station)
	end

	def add_route_to_train(first_station_name, last_station_name, train_number)
		route = self.get_route(first_station_name, last_station_name)
		train = self.get_train(train_number)
		return if !route || !train
		train.add_route(route)
		station = self.get_station(first_station_name)
		station.arrive_train(train)
	end

	def add_wagon_to_train(wagon, train_number)
		train = self.get_train(train_number)
		return if !train
		train.add_wagon(wagon)
	end

	def del_wagon_from_train(train_number)
		train = self.get_train(train_number)
		return if !train
		train.del_wagon
	end

	def move_train_forward(train_number)
		train = self.get_train(train_number)
		return if !train
		train.move_forward
		prev_station = train.get_prev_station
		prev_station.depart_train(train)
		current_station = train.get_current_station
		current_station.arrive_train(train)
	end

	def move_train_backward(train_number)
		train = self.get_train(train_number)
		return if !train
		train.move_backward
		next_station = train.get_next_station
		next_station.depart_train(train)
		current_station = train.get_current_station
		current_station.arrive_train(train)
	end

	def get_stations
		self.stations.values 
	end

	def get_station_trains(station_name)
		station = self.get_station(station_name)
		return station.trains if station
	end

	private

	def get_route(first_station_name, last_station_name)
		(self.routes.has_key?(first_station_name) && self.routes[first_station_name].has_key?(last_station_name)) ? self.routes[first_station_name][last_station_name] : nil
	end

	def get_station(station_name)
		self.stations[station_name]
	end

	def get_train(number)
		train = self.trains[number]
	end
end