require 'player'

describe Player do
  let(:player) { Player.new }
  
it "should have $100 on begin of game" do
    expect(player.bank).to eq(100)
  end
end

