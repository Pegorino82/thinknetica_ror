require_relative 'station'

module StationManager
  private

  def get_station(name)
    @stations.detect { |station| station.name == name }
  end

  def create_station
    station = Station.new(ask_data('Enter station name: '))
    @stations.push(station)

    puts "Station #{station.name} created" if station
  end

  def show_all_stations
    puts 'No stations' if @stations.size.zero?
    @stations.each do |station|
      puts "Station #{station.name}"
    end
  end

  def show_station_trains
    name = ask_data('Enter station name: ')

    station = get_station(name)
    return puts "No station #{name}" unless station

    if station.trains.size.zero?
      puts "No trains on station #{name}"
      return
    end
    station.each_train { |train| puts "Train #{train.type} \##{train.number} wagons: #{train.wagons.size}" }
  end
end
