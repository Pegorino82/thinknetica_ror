=begin
	Класс Route (Маршрут):
	Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции 
	указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
	Может добавлять промежуточную станцию в список
	Может удалять промежуточную станцию из списка
	Может выводить список всех станций по-порядку от начальной до конечной
=end

class Route

	def initialize(start_station, end_station)
		@start_station = start_station
		@end_station = end_station
		@stations = []
	end

	def stations()
		return [@start_station, @stations, @end_station].flatten.compact
	end

	def add_station(station)
		@stations.push(station)
	end

	def del_station(station)
		@stations.delete(station)
	end
end