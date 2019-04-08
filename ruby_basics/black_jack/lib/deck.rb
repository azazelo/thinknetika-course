require_relative 'tools/string'
require_relative 'card'

module Deck
  NONTRUMPS   = (2..10).to_a.map { |i| [i.to_s, i] }.to_h
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
    res = []
    SUITS.each do |suit_name, suit_view|
      RANKS.each do |rank, value|
        res << Card.new(suit_name, suit_view, rank, value)
      end
    end
    res
  end

  def self.calc(cards_array)
    sum = 0
    cards_array.each do |card|
      sum += card.value.respond_to?(:call) ? card.value.call(sum) : card.value
    end
    sum
  end
end
