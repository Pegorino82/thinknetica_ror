require_relative 'wagon'

class CargoWagon < Wagon

  def initialize(total_volume)
    @total_volume = total_volume
    @taken_volume = 0
  end

  def add_volume(volume)
    @taken_volume += volume if @taken_volume < @total_volume
  end

  def taken_volume
    @taken_volume
  end

  def free_volume
    @total_volume - @taken_volume
  end

  def type
    @type = 'cargo'
  end
end
