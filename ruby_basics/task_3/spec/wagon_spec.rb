require 'train'
require 'passenger_train'

require 'passenger_wagon'
require 'cargo_wagon'
require 'types'
require 'messages'
include Messages::Train

describe Train do
  before(:each) do
    @number = "001"
    @type_cargo = Types::CARGO
    @type_passenger = Types::PASSENGER

    @passenger_wagon = PassengerWagon.new(@number)
    @cargo_wagon = CargoWagon.new(@number)
  end

  it "should be created with numbers '#{@number}'" do
    expect(@passenger_wagon.number).to eq(@number)
  end

  it "should be created with types 'Passenger'" do
    expect(@passenger_wagon.type).to eq(@type_passenger)
  end

  it "should raise exception if there is no number passed" do
    expect { PassengerWagon.new() }.to raise_error(ArgumentError)
  end

  it "should raise exception if number is empty string" do
    expect { PassengerWagon.new("") }.to raise_error(RuntimeError)
  end

  it "should raise exception if number got wrong format. Right one is 'ddd'" do
    expect { PassengerWagon.new("1") }.to raise_error(RuntimeError)
  end

end
