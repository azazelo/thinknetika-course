require 'player'

let(:player) { Player.new }

describe Player do
  it "should have $100 on begin of game" do
    expect(player.bank).to eq(100)
  end
end

