require_relative 'wagon'

class CargoWagon < Wagon
  def type
    Types::CARGO
  end
end
