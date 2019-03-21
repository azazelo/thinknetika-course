class Deck
  attr_reader :cards

  def initialize
    @suits = suits
    @cards = create_cards
  end

  private

  def create_cards
    res = {}
    @suits.each do |suit|
      card_faces.each { |face, value| res["#{face}#{suit}"] = value }
    end
    res
  end

  def suits
#    %w[hearts clubs diamonds spades]
#    ["\u2661", "\u2662", "\u2667", "\u2664"].map{ |s| s.encode('utf-8') }
    ["\u2665", "\u2666", "\u2663", "\u2660"].map{ |s| s.encode('utf-8') }
  end

  def card_faces
    non_trumps.merge(trumps).merge(ace)
  end

  def non_trumps
    (2..10).to_a.map { |i| [i, i] }.to_h
  end

  def trumps
    %w[J Q K].map { |face| [face, 10] }.to_h
  end

  def ace
    { 'A' => [1, 11] }
  end
end
