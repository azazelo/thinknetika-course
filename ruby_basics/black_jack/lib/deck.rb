require_relative 'tools/string'
module Deck
  NONTRUMPS   = (2..10).to_a.map { |i| [i, i] }.to_h
  TRUMP_VALUE = 10
  TRUMPS      = %w[J Q K].map { |face| [face, TRUMP_VALUE] }.to_h
  ACE         = { 'A' => proc { |sum| sum <= 10 ? 11 : 1 } }.freeze
  RANKS       = NONTRUMPS.merge(TRUMPS).merge(ACE)

  HEARTS     = "\u2665".red.freeze
  DIAMONDS   = "\u2666".red.freeze
  CLUBS      = "\u2663".freeze
  SPADES     = "\u2660".freeze
  SUIT_VIEWS = [HEARTS, DIAMONDS, CLUBS, SPADES].freeze
  SUIT_NAMES = %w[HEARTS DIAMONDS CLUBS SPADES].freeze
  SUITS      = SUIT_NAMES.zip(SUIT_VIEWS).to_h
  
  def self.cards
    res = {}
    SUIT_NAMES.each do |name|
      RANKS.each { |rank, value| res["#{rank}-#{name}"] = value }
    end
    res
  end
  
  def self.score(cards_array)
    sum = 0
    cards_array.each do |card|
      sum += card[1].respond_to?(:call) ? card[1].call(sum) : card[1]
    end
    sum
  end
end
