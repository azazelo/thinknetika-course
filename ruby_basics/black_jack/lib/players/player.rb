class Player
  attr_accessor :bank
  attr_reader :name

  def initialize(name = nil)
    @bank = 100
  end
end