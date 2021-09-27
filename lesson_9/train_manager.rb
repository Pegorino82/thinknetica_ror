require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'route'

module TrainManager
  private

  TRAIN_TYPES = %w[p c].freeze

  def get_train(number)
    @trains.detect { |train| train.number == number }
  end

  def ask_train_type
    train_type_attempt = 0
    begin
      train_type = ask_data("Enter train type ('p' - passenger, 'c' - cargo): ").downcase
      validate_train_type_input! train_type
      train_type
    rescue StandardError => e
      train_type_attempt += 1
      puts show_failed_input(e.message, train_type_attempt)
      retry if train_type_attempt < 5
    end
  end

  def create_train
    train_type = ask_train_type
    return unless train_type

    train_number_attempt = 0

    begin
      train_number = ask_data('Enter train number: ').downcase
      train = train_type == 'p' ? PassengerTrain.new(train_number) : CargoTrain.new(train_number)
    rescue StandardError => e
      train_number_attempt += 1
      puts show_failed_input(e.message, train_number_attempt)
      retry if train_number_attempt < 5
    end
    @trains.push(train)
    puts "Train #{train.number} created" if train
  end

  def show_train_wagons
    train_number = ask_data('Enter train number: ')

    train = get_train(train_number)
    return unless train

    number = 1
    train.each_wagon do |wagon|
      puts "\t\##{number} #{wagon.type} free #{wagon.class::UNITS}: #{wagon.free_place}
            taken #{wagon.class::UNITS}: #{wagon.used_place}"
    end
  end

  def add_route_to_train
    first_station_name = ask_data('Enter first station name: ')
    last_station_name = ask_data('Enter last station name: ')

    route = get_route(first_station_name, last_station_name)
    train = get_train(ask_data('Enter train number: '))
    return if !route || !train

    train.add_route(route)
    get_station(first_station_name).arrive_train(train)

    puts "Route #{route.stations.first.name} - #{route.stations.last.name} added to train #{train.number}"
  end

  def add_wagon_to_train
    train = get_train(ask_data('Enter train number: '))
    return unless train

    attempt = 0
    begin
      wagon = create_wagon
      fill_wagon(wagon)
      train.add_wagon(wagon)
      puts "Add #{wagon.type} wagon to train #{train.number}"
    rescue StandardError => e
      attempt += 1
      puts e
      retry if attempt < 5
      nil
    end
  end

  def del_wagon_from_train
    train = get_train(ask_data('Enter train number: ')).del_wagon

    puts "Delete wagon from train #{train.number}"
  end

  def move_train_forward
    train = get_train(ask_data('Enter train number: '))
    return if !train || !train.route

    train.move_forward
    prev_station = train.prev_station
    prev_station.depart_train(train)
    current_station = train.current_station
    current_station.arrive_train(train)

    puts "Train #{train.number} moved to #{current_station.name} from #{prev_station.name}"
  end

  def move_train_backward
    train = get_train(get_train(ask_data('Enter train number: ')))
    return if !train || !train.route

    train.move_backward
    next_station = train.next_station
    next_station.depart_train(train)
    current_station = train.current_station
    current_station.arrive_train(train)

    puts "Train #{train.number} moved to #{current_station.name} from #{next_station.name}"
  end

  def validate_train_type_input!(type)
    raise 'Train type must be Passenger or Cargo.' unless TRAIN_TYPES.include? type
  end
end
