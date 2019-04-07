require 'players/player'
require 'players/human'
require 'players/diller'

describe Player do
  let(:player) { Player.new }

  it 'should have $100 on begin of game' do
    expect(player.bank).to eq(100)
  end
end

describe Human do
  let(:human) { Human.new('Ivan') }

  it 'should have $100 on begin of game' do
    expect(human.bank).to eq(100)
  end

  it 'should have name Ivan on' do
    expect(human.name).to eq('Ivan')
  end
end

describe Diller do
  let(:diller) { Diller.new }

  it 'should have $100 on begin of game' do
    expect(diller.bank).to eq(100)
  end

  it 'should have name Diller' do
    expect(diller.name).to eq('Diller')
  end
end
