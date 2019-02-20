require 'cargo_train'
require 'station'
require 'messages'
include Messages::Train

describe Station do


  before :context do
    @type_cargo =  Types::CARGO
    @train_number = "10a-01"
    @train = CargoTrain.new(@train_number)
    @station_name = "Москва"
    @station =  Station.new(@station_name)
  end

  it "should raise exception if created with name in wrong format" do
    expect{ Station.new(" ") }.to raise_error(RuntimeError)
  end

  it "should raise exception if created with blank name" do
    expect{ Station.new("") }.to raise_error(RuntimeError)
  end

  it "should raise exception if created without arguments" do
    expect{ Station.new() }.to raise_error(ArgumentError)
  end

  it "should raise exception if created with blank name" do
    expect{ Station.new("") }.to raise_error(RuntimeError)
  end

  it "should raise exception if created station with existing name" do
    expect{ Station.new(@station_name) }.to raise_error(RuntimeError)
  end

  it "should be created with name" do
    expect(@station.name).to eq(@station_name)
  end

  it "can receive train" do
    @station.receive_train(@train)
    expect(@station.trains.size).to eq(1)
  end

  it "can dispatch train" do
    @station.dispatch_train(@train)
    expect(@station.trains.size).to eq(0)
  end

  it "can return train list" do
    @station.receive_train(@train)
    expect(@station.train_list([@train]).join('. ')).to include("1.")
  end

  it "can return train list by type" do
    @station.receive_train(@train)
    expect(@station.train_list_by_type(@type_cargo).join('. ')).to include("1.")
  end
end
