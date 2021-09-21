=begin
	Класс Train (Поезд):
	Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные 
	указываются при создании экземпляра класса
	Может набирать скорость
	Может возвращать текущую скорость
	Может тормозить (сбрасывать скорость до нуля)
	Может возвращать количество вагонов
	Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). 
	Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
	Может принимать маршрут следования (объект класса Route). 
	При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
	Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
	Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
=end

class Train
	attr_reader :number, :speed, :wagons, :route

	def initialize(number)
		@number = number
		@wagons = []
		@speed = 0
		@route = nil
		@current_station_index = nil
	end

	def speed_up(value)
		@speed += value
	end

	def stop
		@speed = 0
	end
	
	def add_wagon(wagon)
		add_wagon!(wagon)
	end

	def del_wagon
		wagons.pop if speed == 0 && wagons.size > 0
	end

	def add_route(route)
		@route = route
		@current_station_index = 0
	end

	def move_forward
		@current_station_index += 1 if @current_station_index < route.stations.size
	end

	def move_backward
		@current_station_index -= 1 if @current_station_index > 0
	end

	def get_current_station
		route.stations[@current_station_index]
	end

	def get_next_station
		route.stations[@current_station_index + 1]
	end

	def get_prev_station
		route.stations[@current_station_index - 1]
	end

	protected

	# пользователь не должен иметь возможности поменять тип поеза
	def type
		'unset'
	end

	# запрещаем прицеплять к поезду вагоны другого типа
	def add_wagon!(wagon)
		wagons.push(wagon) if wagon.type == type
	end
end