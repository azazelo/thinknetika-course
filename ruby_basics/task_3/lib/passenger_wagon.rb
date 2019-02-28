require_relative 'wagon'

class PassengerWagon < Wagon
  attr_accessor :seats, :occupied
  validates :seats, :numeric => true, :presence => true

  def initialize(number, seats)
    @number = number
    @seats = seats
    @occupied = 0
    validate!
  end

  def occupy
    return there_is_no_more_free_seats_to_occupy if self.free_seats.zero?
    @occupied += 1
  end

  def vacate
    return there_is_no_more_passengers_in if self.occupied.zero?
    @occupied -= 1
  end

  def free_seats
    @seats - @occupied
  end

  def type
    Types::PASSENGER
  end

  def info
    "##{@number}, #{self.type}, занято мест: #{@occupied}, свободно мест: #{self.free_seats}"
  end

end
