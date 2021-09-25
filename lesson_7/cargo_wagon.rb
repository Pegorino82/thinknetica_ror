require_relative 'wagon'

class CargoWagon < Wagon
  UNITS = 'm3'

  def initialize(total_volume)
    super (total_volume)
  end

  def add_volume(volume)
    @used_place += volume if free_place >= volume
  end

  def type
    @type = 'cargo'
  end
end
