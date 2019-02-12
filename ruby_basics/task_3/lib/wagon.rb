class Wagon
  attr_reader :number
  def initialize(number)
    @number = number
  end

  def info
    "##{@number}"
  end
end
