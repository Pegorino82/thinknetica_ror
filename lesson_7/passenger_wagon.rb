require_relative 'wagon'

class PassengerWagon < Wagon
  UNITS = 'seats'

  def initialize(total_seats)
    super (total_seats)
  end

  def take_seat
    @used_place += 1 if free_place > 0
  end

  def type
    @type = 'passenger'
  end
end
