class Deck
  attr_reader :cards, :suits

  def initialize
    @suits = %w[hearts clubs diamonds spades]
    @cards = create_cards
  end

  private

  def create_cards
    res = []
    @suits.each do |suit|
      res += card_faces.map { |face| "#{face}-#{suit}" }.flatten
    end
    res
  end

  def card_faces
    non_trumps + trumps
  end

  def non_trumps
    (2..10).to_a
  end

  def trumps
    %w[ace king queen jack]
  end
end
