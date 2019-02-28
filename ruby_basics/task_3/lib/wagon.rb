require_relative 'maker'
require_relative 'validations'
class Wagon
  include Validations
  include Maker

  attr_reader :name, :type
  validates :name, presence: true
  validates :type,  presence: true, inclusion: Types::ALL

  def initialize(name)
    @name = name
    validate!
  end

  def info
    "##{@name}"
  end
end
