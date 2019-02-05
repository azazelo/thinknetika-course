require 'train'

describe Train do
  before(:each) do
    @train = Train.new('001', "Passenger", 10)
    @station_a = Station.new("A")
    @station_b = Station.new("B")
    @station_c = Station.new("C")

    @route = Route.new(@station_a, @station_c)
    @route.add_station(@station_b)
    @train.accept(@route)
  end

  it "should be created with numbers '001'" do
    expect(@train.number).to eq('001')
  end

  it "should be created with types 'Passenger'" do
    expect(@train.type).to eq('Passenger')
  end

  it "can increase speed and display current speed" do
    @train.increase_speed(10)
    expect(@train.speed).to eq(10)
  end

  it "can stop" do
    @train.stop
    expect(@train.speed).to eq(0)
  end

  it "can display wagon qty" do
    expect(@train.wagon_qty).to eq(10)
  end

  it "can add wagon if speed > 0" do
    @train.add_wagon
    expect(@train.wagon_qty).to eq(11)
  end

  it "can not add wagon if speed == 0" do
    @train.stop
    @train.add_wagon
    expect(@train.wagon_qty).to eq(11)
  end

  it "can remove wagon if speed > 0" do
    @train.increase_speed(10)
    @train.remove_wagon
    expect(@train.wagon_qty).to eq(10)
  end

  it "can not remove wagon if speed == 0" do
    @train.stop
    @train.remove_wagon
    expect(@train.wagon_qty).to eq(9)
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

  it "can NOT move forward" do
    @train.increase_speed(10)
    @train.go_forward
    expect(@train.current_station).to eq(@station_b)
  end

  it "can move backward" do
    @train.increase_speed(10)
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

end
