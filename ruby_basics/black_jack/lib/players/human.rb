require_relative 'player'

class Human < Player
  def initialize(name)
    @name = name
    super
  end
end
