require_relative 'maker'
require_relative 'validations'
class Wagon
  include Validations
  include Maker

  attr_reader :number, :type
  validates :number, presence: true, format: /[\d]{3}/
  validates :type,  presence: true, inclusion: Types::ALL

  def initialize(number)
    @number = number
    validate!
  end

  def info
    "##{@number}"
  end
end
