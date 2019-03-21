class Deck
  attr_reader :cards, :suits

  def initialize
    @suits = %w[hearts clubs diamonds spades]
    @cards = create_cards
  end

  private

  def create_cards
    res = {}
    @suits.each do |suit|
      card_faces.each { |face, value| res["#{face}-#{suit}"] = value }
    end
    res
  end

  def card_faces
    non_trumps.merge(trumps).merge(ace)
  end

  def non_trumps
    (2..10).to_a.map { |i| [i, i] }.to_h
  end

  def trumps
    %w[jack queen king].map { |face| [face, 10] }.to_h
  end
  
  def ace
    { 'ace' => [1, 11] }
  end
end
