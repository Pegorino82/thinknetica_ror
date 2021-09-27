require_relative 'wagon'

class CargoWagon < Wagon
  UNITS = 'm3'.freeze

  def add_volume(volume)
    @used_place += volume if free_place >= volume
  end

  def type
    @type = 'cargo'
  end
end
