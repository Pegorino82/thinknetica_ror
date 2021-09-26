require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

module WagonManager
  private

  WAGON_TYPES = {
    'p' => { units: 'seats', constructor: PassengerWagon },
    'c' => { units: 'm3', constructor: CargoWagon }
  }.freeze

  def create_wagon
    wagon_type = nil
    loop do
      print "Enter wagon type ('p' - passenger, 'c' - cargo): "
      wagon_type = gets.chomp.downcase
      break if WAGON_TYPES.key? wagon_type
    end
    print "Enter total #{WAGON_TYPES[wagon_type][:units]}: "
    total_palace = gets.chomp.to_i
    WAGON_TYPES[wagon_type][:constructor].new(total_palace)
  end

  def fill_wagon(wagon)
    loop do
      print "Do you want to #{wagon.type == 'cargo' ? 'add' : 'take'} #{wagon.class::UNITS} (y/<any>)?"
      to_add = gets.chomp.downcase
      break if to_add != 'y'

      case wagon.type
      when 'passenger'
        wagon.take_seat
      when 'cargo'
        print 'Enter volume to add: '
        wagon.add_volume(gets.chomp.to_i)
      end
    end
  end
end
