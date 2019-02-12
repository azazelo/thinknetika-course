require_relative 'train'

class PassengerTrain < Train
  def type
    Types::PASSENGER
  end
end
