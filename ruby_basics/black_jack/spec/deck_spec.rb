require 'deck'

describe Deck do
  it 'should create new Deck with 52 cards' do
    expect(Deck.cards.size).to eq(52)
  end
end
