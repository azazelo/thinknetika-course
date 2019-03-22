require 'players/player'
require 'players/human'
require 'players/computer'

describe Player do
  let(:player) { Player.new }
  
  it "should have $100 on begin of game" do
    expect(player.bank).to eq(100)
  end
end

describe Human do
  let(:human) { Human.new('Ivan') }
  
  it "should have $100 on begin of game" do
    expect(human.bank).to eq(100)
  end

  it "should have name Ivan on" do
    expect(human.name).to eq('Ivan')
  end
end

describe Computer do
  let(:computer) { Computer.new }
  
  it "should have $100 on begin of game" do
    expect(computer.bank).to eq(100)
  end

  it "should have name Robot" do
    expect(computer.name).to eq('Robot')
  end
end

