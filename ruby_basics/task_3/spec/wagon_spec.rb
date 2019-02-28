# require 'wagon'
# require 'passenger_wagon'
# require 'cargo_wagon'
# require 'types'
require 'messages'
include Messages::Wagon

describe Wagon do
  let(:number) { "001" }
  let(:type_cargo) { Types::CARGO }
  let(:type_passenger) { Types::PASSENGER }
  let(:cargo_wagon) { CargoWagon.new(number, 1000) }
  let(:passenger_wagon) { PassengerWagon.new(number, 50) }

  it "should be created with number" do
    expect(passenger_wagon.number).to eq(number)
  end

  it "should be able to create new instance with type 'Passenger'" do
    expect(passenger_wagon.type).to eq(type_passenger)
  end

  it "should be able to create new instance with type 'Cargo'" do
    expect(cargo_wagon.type).to eq(type_cargo)
  end

  it "should raise exception if there is no number passed" do
    expect { PassengerWagon.new() }.to raise_error(ArgumentError)
  end

  it "should raise exception if number is empty string" do
    expect { PassengerWagon.new("", 50) }.to raise_error(RuntimeError)
  end
end
