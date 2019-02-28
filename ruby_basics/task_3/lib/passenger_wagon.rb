require_relative 'wagon'

class PassengerWagon < Wagon
  def type
    Types::PASSENGER
  end
end
