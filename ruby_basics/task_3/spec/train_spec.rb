require 'spec_helper'

describe 'Exception', Train do
  it 'should raise exception if there is no number' do
    expect { PassengerTrain.new }.to raise_error(ArgumentError)
  end

  it 'should raise exception if number is empty string' do
    expect { PassengerTrain.new('') }.to raise_error(RuntimeError)
  end

  it 'should raise exception if number got wrong format' do
    expect { PassengerTrain.new('1') }.to raise_error(RuntimeError)
  end
end

describe 'Creating and display', Train do
  before :context do
    @number = 'C01-A1'
    @passenger_train = PassengerTrain.new(@number)
    @type_passenger = Types::PASSENGER
  end

  it 'should be created with 111-11 number' do
    expect(@passenger_train.number).to eq(@number)
  end

  it 'should be created with type <Passenger>' do
    expect(@passenger_train.type).to eq(@type_passenger)
  end

  it 'can increase speed and display current speed' do
    @passenger_train.stop
    @passenger_train.increase_speed(10)
    expect(@passenger_train.speed).to eq(10)
  end
end

describe 'stop, add and remove wagons', Train do
  before :context do
    @number = 'C01-A1'
    @passenger_wagon = PassengerWagon.new('001', 20)
    @passenger_train =
      PassengerTrain.instances.last || PassengerTrain.new(@number)
    @passenger_train.add_wagon(@passenger_wagon)
  end

  it 'can stop, remove wagon' do
    @passenger_train.stop
    expect(@passenger_train.speed).to eq(0)
    @passenger_train.remove_wagon('001')
    expect(@passenger_train.wagons.size).to eq(0)
  end

  it 'can not add/remove wagon if speed > 0' do
    @passenger_train.increase_speed(10)
    expect(@passenger_train.add_wagon(@passenger_wagon)).to eq(
      Train.speed_is_not_zero
    )
    expect(@passenger_train.remove_wagon('001')).to eq(
      Train.speed_is_not_zero
    )
  end
end

describe 'moving', Train do
  before :context do
    @station_a = Station.new('A')
    @station_b = Station.new('B')
    @station_c = Station.new('C')
    @route = Route.new('A-C', @station_a, @station_c).add_station(@station_b)
    @passenger_train =
      PassengerTrain.instances.last || PassengerTrain.new(@number)
    @passenger_train.accept(@route).increase_speed(10)
  end
  it 'can accept route, current_station to be equal first station of route' do
    expect(@passenger_train.current_station).to eq(@route.stations.first)
  end

  it 'move' do
    3.times { @passenger_train.go_backward }
    expect(@passenger_train.current_station).to eq(@station_a)
    expect(@passenger_train.go_backward).to eq(
      Train.at_first_station
    )
    expect(@passenger_train.go_forward.current_station).to eq(@station_b)
    expect(@passenger_train.go_forward.go_forward).to eq(
      Train.at_last_station
    )
  end
end

describe 'return stations', Train do
  before :context do
    @station_a = Station.find(:name, 'A') || Station.new('A')
    @station_b = Station.find(:name, 'B') || Station.new('B')
    @station_c = Station.find(:name, 'C') || Station.new('C')
    @route =
      Route.find(:name, 'A-C') || Route.new('A-C', @station_a, @station_c)
    @route.add_station(@station_b)
    @type_passenger = Types::PASSENGER
    @passenger_wagon = PassengerWagon.new('001', 20)
    @cargo_wagon = CargoWagon.new('002', 1000)
    @type_cargo = Types::CARGO
    @number = 'C01-A1'
    @passenger_train =
      PassengerTrain.instances.last || PassengerTrain.new(@number)
    @passenger_train.accept(@route)
  end
end
