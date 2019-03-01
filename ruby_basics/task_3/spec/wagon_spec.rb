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

  it "should return #{there_is_nothing_to_pull}" do
    expect(cargo_wagon.pull(1)).to eq(there_is_nothing_to_pull)
  end

  it "should return #{you_trying_to_push_more_than_wagon_can_carry}" do
    expect(cargo_wagon.push(2000)).to eq(you_trying_to_push_more_than_wagon_can_carry)
  end

  it "should return #{free_space_is_too_small_for_this_qty}" do
    expect(cargo_wagon.push(500).push(550)).to eq(free_space_is_too_small_for_this_qty)
  end

  it "should return #{there_is_no_more_free_space_to_push}" do
    expect(cargo_wagon.push(1000).push(550)).to eq(there_is_no_more_free_space_to_push)
  end

end
