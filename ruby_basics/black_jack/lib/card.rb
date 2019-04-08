class Card
  attr_reader :suit_name, :suit_view, :rank, :value

  def initialize(suit_name, suit_view, rank, value)
    @suit_name = suit_name
    @suit_view = suit_view
    @rank = rank
    @value = value
  end
end
