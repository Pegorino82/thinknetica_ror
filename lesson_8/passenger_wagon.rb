require_relative 'wagon'

class PassengerWagon < Wagon
  UNITS = 'seats'.freeze

  def take_seat
    @used_place += 1 if free_place.positive?
  end

  def type
    @type = 'passenger'
  end
end
