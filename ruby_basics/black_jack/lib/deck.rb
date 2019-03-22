module Deck
  NONTRUMPS   = (2..10).to_a.map { |i| [i, i] }.to_h
  TRUMP_VALUE = 10
  TRUMPS      = %w[J Q K].map { |face| [face, TRUMP_VALUE] }.to_h
  ACE         = { 'A' => proc { |score| score <= 10 ? 11 : 1 } }.freeze
  RANKS       = NONTRUMPS.merge(TRUMPS).merge(ACE)

  HEARTS     = "\u2665".freeze
  DIAMONDS   = "\u2666".freeze
  CLUBS      = "\u2663".freeze
  SPADES     = "\u2660".freeze
  SUIT_NAMES = %w[hearts diamonds clubs spades].freeze
  SUIT_VIEWS = [HEARTS, DIAMONDS, CLUBS, SPADES].freeze
  SUITS      = SUIT_NAMES.zip(SUIT_VIEWS).to_h
  
  def self.cards
    res = {}
    SUIT_NAMES.each do |name|
      RANKS.each { |rank, value| res["#{rank}-#{name}"] = value }
    end
    res
  end
end
