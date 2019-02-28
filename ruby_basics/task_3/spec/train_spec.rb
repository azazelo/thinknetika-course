require 'passenger_train'
require 'cargo_train'

# require 'wagon'
require 'passenger_wagon'
require 'cargo_wagon'
require 'types'
require 'messages'
include Messages::Train

describe Train do

  before :context do
    @station_a = Station.new('A')
    @station_b = Station.new('B')
    @station_c = Station.new('C')
    @route = Route.new("A-C", @station_a, @station_c).add_station(@station_b)
    @type_passenger = Types::PASSENGER
    @passenger_wagon = PassengerWagon.new('001', 20)
    @cargo_wagon = CargoWagon.new('002', 1000)
    @type_cargo = Types::CARGO
    @number = "C01-A1"
    @passenger_train = PassengerTrain.new(@number)
    @passenger_train.accept(@route)
  end

  it "should raise exception if there is no number" do
    expect{ PassengerTrain.new() }.to raise_error(ArgumentError)
  end

  it "should raise exception if number is empty string" do
    expect{ PassengerTrain.new("") }.to raise_error(RuntimeError)
  end

  it "should raise exception if number got wrong format" do
    expect{ PassengerTrain.new("1") }.to raise_error(RuntimeError)
  end

  it "should be created with 111 number" do
    expect(@passenger_train.number).to eq(@number)
  end

  it "should be created with type 'Passenger'" do
    expect(@passenger_train.type).to eq(@type_passenger)
  end

  it "can increase speed and display current speed" do
    @passenger_train.stop
    @passenger_train.increase_speed(10)
    expect(@passenger_train.speed).to eq(10)
  end

  it "can stop" do
    @passenger_train.stop
    expect(@passenger_train.speed).to eq(0)
  end

  it "can not add wagon if speed > 0" do
    @passenger_train.increase_speed(10)
    expect(@passenger_train.add_wagon(@passenger_wagon)).to eq(can_not_add_wagon + speed_is_not_zero)
  end

  it "can not remove wagon if speed > 0" do
    @passenger_train.increase_speed(10)
    expect(@passenger_train.remove_wagon('001')).to eq(can_not_remove_wagon + speed_is_not_zero)
  end

  it "can not remove wagon if speed == 0" do
    @passenger_train.stop
    @passenger_train.remove_wagon('001')
    expect(@passenger_train.wagons.size).to eq(0)
  end

  it "can accept route, current_station to be equal first station of route" do
    expect(@passenger_train.current_station).to eq(@station_a)
    expect(@passenger_train.current_station).to eq(@route.stations.first)
  end

  it "can not move backward on first station" do
    @passenger_train.go_backward
    expect(@passenger_train.current_station).to eq(@station_a)
  end

  it "can move forward" do
    @passenger_train.increase_speed(10)
    @passenger_train.go_forward
    expect(@passenger_train.current_station).to eq(@station_b)
  end

  it "can NOT move forward on last station" do
    @passenger_train.go_forward
    @passenger_train.go_forward
    expect(@passenger_train.current_station).to eq(@station_c)
  end

  it "can not move backward if on first station in route" do
    @passenger_train.increase_speed(10)
    @passenger_train.go_backward
    @passenger_train.go_backward
    @passenger_train.go_backward
    expect(@passenger_train.current_station).to eq(@station_a)
  end

  it "can return 'previous', 'current' and 'next' stations" do
    @passenger_train.speed = 10
    @passenger_train.go_forward
    expect(@passenger_train.get_station('previous')).to eq(@station_a)
    expect(@passenger_train.get_station('current')).to  eq(@station_b)
    expect(@passenger_train.get_station('next')).to     eq(@station_c)
  end

  it "can get next_station" do
    expect(@passenger_train.get_station("next")).to eq(@station_c)
  end

  it "can NOT get next_station if on last station" do
    @passenger_train.current_station = @station_c
    expect(@passenger_train.get_station("next")).to eq(no_next_station)
  end

  it "can get previous_station" do
    @passenger_train.increase_speed(10)
    @passenger_train.go_forward
    expect(@passenger_train.get_station("previous")).to eq(@station_b)
  end


  it "can NOT get previous_station if on first station" do
    @passenger_train.current_station = @station_a
    expect(@passenger_train.get_station("previous")).to eq(no_previous_station)
  end

  it "can get current_station" do
    @passenger_train.current_station = @station_c
    expect(@passenger_train.get_station("current")).to eq(@station_c)
  end
end
