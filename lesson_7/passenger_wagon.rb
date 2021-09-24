require_relative 'wagon'

class PassengerWagon < Wagon

  def initialize(total_seats)
    @total_seats = total_seats
    @taken_seats = 0
  end

  def take_seat
    @taken_seats += 1 if @taken_seats < @total_seats
  end

  def taken_seats
    @taken_seats
  end

  def free_seats
    @total_seats - @taken_seats
  end

  def type
    @type = 'passenger'
  end
end
