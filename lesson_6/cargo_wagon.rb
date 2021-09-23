require_relative 'wagon'

class CargoWagon < Wagon
  
  def type
    @type = 'cargo'
  end
end