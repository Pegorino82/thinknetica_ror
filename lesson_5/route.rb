=begin
	Класс Route (Маршрут):
	Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции 
	указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
	Может добавлять промежуточную станцию в список
	Может удалять промежуточную станцию из списка
	Может выводить список всех станций по-порядку от начальной до конечной
=end
require_relative 'instance_counter'

class Route
  include InstanceCounter
	attr_reader :stations

	def initialize(start_station, end_station)
		@stations = [start_station, end_station]
	end

	# оставляем начальную и конечную станции на своих местах
	def add_station(station)
		stations.insert(-2, station)
	end

	def del_station(station)
		stations.delete(station)
	end
end