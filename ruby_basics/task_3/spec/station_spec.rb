require 'cargo_train'
require 'station'
require 'messages'
include Messages::Train

describe Station do
  before(:each) do
    @station = Station.new("A")
    @type_cargo = Types::CARGO
    @train = CargoTrain.new("001")
    @station.receive_train(@train)
  end

  it "should be created with name A" do
    expect(@station.name).to eq('A')
  end

  it "can receive train" do
    expect(@station.trains.size).to eq(1)
  end

  it "can dispatch train" do
    @station.dispatch_train(@train)
    expect(@station.trains.size).to eq(0)
  end

  it "can return train list" do
    expect(@station.train_list([@train]).join('. ')).to include("1.")
  end

  it "can return train list by type" do
    expect(@station.train_list_by_type(@type_cargo).join('. ')).to include("1.")
  end

end
