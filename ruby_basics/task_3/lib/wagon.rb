require_relative 'maker'
class Wagon
  include Maker
  attr_reader :number
  def initialize(number)
    @number = number
  end

  def info
    "##{@number}"
  end
end
