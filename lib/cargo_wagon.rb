require_relative 'wagon'

class CargoWagon < Wagon
  attr_accessor :volume, :loaded
  validates :volume, :numeric => true, :presence => true

  def initialize(number, volume)
    @number = number
    @volume = volume
    @loaded = 0
    validate!
  end

  def load(weight)
    return there_is_no_more_free_space_to_load if self.free_space.zero?
    return free_space_is_too_small_for_this_weight if weight > self.free_space
    @loaded += weight
  end

  def free_space
    @volume - @loaded
  end

  def type
    Types::CARGO
  end

  def info
    "##{@number}, #{self.type}, загружено: #{@loaded}, свободно: #{self.free_space}"
  end

end
