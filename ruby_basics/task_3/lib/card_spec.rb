require 'card'

describe Card do
  let(:trump_card) { TrumpCard.new }
  let(:nontrump_card) { NontrumpCard.new(2) }
  let(:ace_card) { AceCard.new }

  it 'should create new TrumpCard' do
    expect(trump_card.value).to eq(10)
  end

  it 'should create new NontrumpCard' do
    expect(nontrump_card.value).to eq(2)
  end

  it 'should create new AceCard' do
    expect(ace_card.value).to eq([1,11])
  end

  it 'should create suits' do
    expect(deck.suits.size).to eq(4)
  end
end
