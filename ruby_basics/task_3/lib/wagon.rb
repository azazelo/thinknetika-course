require_relative 'maker'
require_relative 'validations'
require_relative 'messages'

class Wagon
  include Validations
  include Maker
  include Messages::Wagon

  attr_reader :number, :type, :volume, :loaded
  validates :number, presence: true
  validates :type,   presence: true, inclusion: Types::ALL
  validates :volume, presence: true, numeric: true

  def initialize(number, volume)
    @number = number
    @volume = volume
    @loaded = 0
    validate!
  end

  def push(qty = 1)
    return you_trying_to_push_more_than_wagon_can_carry if qty > volume
    return there_is_no_more_free_space_to_push if free_space.zero?
    return free_space_is_too_small_for_this_qty if qty > free_space
    @loaded += qty
    self
  end

  def pull(qty = 1)
    return there_is_nothing_to_pull if loaded.zero?
    return you_trying_to_pull_more_then_loaded if loaded < qty
    @loaded -= qty
    self
  end

  def free_space
    @volume - @loaded
  end

  def info
    "##{@number}, #{type}, всего: #{volume}, занято: #{loaded}, свободно: #{free_space}"
  end
end
