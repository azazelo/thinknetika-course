require 'deck'

describe Deck do
  let(:deck) { Deck.new }
  

  it 'should create new Deck with 52 cards' do
    puts deck.cards.inspect
    expect(deck.cards.size).to eq(52)
  end

  it 'should create 4 colors' do
    expect(deck.suits.size).to eq(4)
  end
end

