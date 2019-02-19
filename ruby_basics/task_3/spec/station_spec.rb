require 'cargo_train'
require 'station'
require 'messages'
include Messages::Train

describe Station do

  before(:each) do
    @type_cargo = Types::CARGO
  end

  it "should raise exception if created with name in wrong format" do
    expect{ Station.new(" ") }.to raise_error(RuntimeError)
    # expect(Station.new("")).to raise_error(RuntimeError)
  end

  it "should raise exception if created with blank name" do
    expect{ Station.new("") }.to raise_error(RuntimeError)
    # expect(Station.new("")).to raise_error(RuntimeError)
  end

  it "should raise exception if created without arguments" do
    expect{ Station.new() }.to raise_error(ArgumentError)
    # expect(Station.new("")).to raise_error(RuntimeError)
  end

  it "should raise exception if created with blank name" do
    expect{ Station.new("") }.to raise_error(RuntimeError)
    # expect(Station.new("")).to raise_error(RuntimeError)
  end

  it "should be created with name" do
    name = "Москва-Товарная"
    station = Station.new(name)
    expect(station.name).to eq(name)
  end

  it "can receive train" do
    train_number = "10a-01"
    train = CargoTrain.new(train_number)
    name = "Москва-Товарная1"
    station = Station.new(name)
    station.receive_train(train)
    expect(station.trains.size).to eq(1)
  end

  it "can dispatch train" do
    train_number = "10a-02"
    train = CargoTrain.new(train_number)
    name = "Москва-Товарная2"
    station = Station.new(name)
    station.receive_train(train)
    station.dispatch_train(train)
    expect(station.trains.size).to eq(0)
  end

  it "can return train list" do
    train_number = "10a-03"
    train = CargoTrain.new(train_number)
    name = "Москва-Товарная3"
    station = Station.new(name)
    station.receive_train(train)
    expect(station.train_list([train]).join('. ')).to include("1.")
  end

  it "can return train list by type" do
    train_number = "10a-04"
    train = CargoTrain.new(train_number)
    name = "Москва-Товарная4"
    station = Station.new(name)
    station.receive_train(train)
    expect(station.train_list_by_type(@type_cargo).join('. ')).to include("1.")
  end
end
