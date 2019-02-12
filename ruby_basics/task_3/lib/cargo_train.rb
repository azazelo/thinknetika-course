require_relative 'train'

class CargoTrain < Train
  def type
    Types::CARGO
  end
end
