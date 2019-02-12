require 'train'
require 'passenger_train'

require 'passenger_wagon'
require 'cargo_wagon'
require 'types'
require 'messages'
include Messages::Train

describe Train do
  before(:each) do
    @train = PassengerTrain.new('001')
    @station_a = Station.new("A")
    @station_b = Station.new("B")
    @station_c = Station.new("C")
    @type_cargo = Types::CARGO
    @type_passenger = Types::PASSENGER

    @route = Route.new("A-C", @station_a, @station_c)
    @route.add_station(@station_b)
    @train.accept(@route)

    @passenger_wagon = PassengerWagon.new('001')
    @cargo_wagon = CargoWagon.new('002')
  end

  it "should be created with numbers '001'" do
    expect(@train.number).to eq('001')
  end

  it "should be created with types 'Passenger'" do
    expect(@train.type).to eq(@type_passenger)
  end

  it "can increase speed and display current speed" do
    @train.increase_speed(10)
    expect(@train.speed).to eq(10)
  end

  it "can stop" do
    @train.stop
    expect(@train.speed).to eq(0)
  end

  it "can add wagon if speed > 0 and wagon_type same as train_type" do
    @train.add_wagon(@passenger_wagon)
    expect(@train.wagons.size).to eq(1)
  end

  it "can not add wagon if speed != 0" do
    @train.increase_speed(10)
    expect(@train.add_wagon(@passenger_wagon)).to eq(can_not_add_wagon + speed_is_not_zero)
  end

  it "can remove wagon if speed > 0" do
    @train.increase_speed(10)
    expect(@train.remove_wagon('001')).to eq(can_not_remove_wagon + speed_is_not_zero)
  end

  it "can not remove wagon if speed == 0" do
    @train.stop
    @train.remove_wagon('001')
    expect(@train.wagons.size).to eq(0)
  end

  it "can accept route, current_station to be equal first station of route" do
    expect(@train.current_station).to eq(@station_a)
    expect(@train.current_station).to eq(@route.stations.first)
  end

  it "can move forward" do
    @train.increase_speed(10)
    @train.go_forward
    expect(@train.current_station).to eq(@station_b)
  end

  it "can NOT move forward on last station" do
    @train.increase_speed(10)
    @train.current_station = @station_c
    @train.go_forward
    expect(@train.current_station).to eq(@station_c)
  end

  it "can move backward on first station" do
    @train.increase_speed(10)
    @train.current_station = @station_a
    @train.go_backward
    expect(@train.current_station).to eq(@station_a)
  end

  it "can not move backward if on first station in route" do
    @train.increase_speed(10)
    @train.go_backward
    expect(@train.current_station).to eq(@station_a)
  end

  it "can return 'previous', 'current' and 'next' stations" do
    @train.increase_speed(10)
    @train.go_forward
    expect(@train.get_station('previous')).to eq(@station_a)
    expect(@train.get_station('current')).to  eq(@station_b)
    expect(@train.get_station('next')).to     eq(@station_c)
  end

  it "can get next_station" do
    expect(@train.get_station("next")).to eq(@station_b)
  end

  it "can NOT get next_station if on last station" do
    @train.current_station = @station_c
    expect(@train.get_station("next")).to eq(no_next_station)
  end

  it "can get previous_station" do
    @train.current_station = @station_c
    expect(@train.get_station("previous")).to eq(@station_b)
  end


  it "can NOT get previous_station if on first station" do
    @train.current_station = @station_a
    expect(@train.get_station("previous")).to eq(no_previous_station)
  end

  it "can get current_station" do
    @train.current_station = @station_c
    expect(@train.get_station("current")).to eq(@station_c)
  end
end
