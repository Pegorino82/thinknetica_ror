module RouteManager
  private

  def get_route(first_station_name, last_station_name)
    @routes.detect do |route|
      (route.stations.first.name == first_station_name && route.stations.last.name == last_station_name)
    end
  end

  def create_route
    print 'Enter first station name: '
    first_station_name = gets.chomp
    print 'Enter last station name: '
    last_station_name = gets.chomp

    first_station = get_station(first_station_name)
    last_station = get_station(last_station_name)
    route = Route.new(first_station, last_station)
    @routes.push(route)
    puts "Route #{route.stations.first.name} - #{route.stations.last.name} created" if route
  end

  def add_station_to_route
    print 'Enter station name: '
    station_name = gets.chomp
    print 'Enter first station name: '
    first_station_name = gets.chomp
    print 'Enter last station name: '
    last_station_name = gets.chomp

    route = get_route(first_station_name, last_station_name)
    station = get_station(station_name)
    return if !route || !station

    route.add_station(station)

    puts "Station #{station.name} added to route  #{route.stations.first} - #{route.stations.last}"
  end

  def del_station_from_route
    print 'Enter station name: '
    station_name = gets.chomp
    print 'Enter first station name: '
    first_station_name = gets.chomp
    print 'Enter last station name: '
    last_station_name = gets.chomp

    route = get_route(first_station_name, last_station_name)
    station = get_station(station_name)
    return if !route || !station

    route.del_station(station)

    puts "Station #{station.name} deleted from route  #{route.stations.first} - #{route.stations.last}"
  end
end
