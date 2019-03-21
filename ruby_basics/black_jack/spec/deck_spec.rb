require 'deck'

describe Deck do
  let(:deck) { Deck.new }

  it 'should create new Deck with 52 cards' do
    expect(deck.cards.size).to eq(52)
    puts deck.cards
  end

  it 'should create suits' do
    expect(deck.suits.size).to eq(4)
  end
end
