require 'route'

describe Route do
  before(:each) do
    @station_a = Station.new("A")
    @station_b = Station.new("B")
    @station_c = Station.new("C")

    @route = Route.new("1", @station_a, @station_c)
  end

  it "should be created with name, first stations and last station" do
    expect(@route.name).to eq("1")
    expect(@route.stations.first).to eq(@station_a)
    expect(@route.stations.last).to eq(@station_c)
  end

  it "can add station to list" do
    @route.add_station(@station_b)
    expect(@route.stations.size).to eq(3)
    expect(@route.stations[-2]).to eq(@station_b)
  end

  it "can delete station from list" do
    @route.delete_station(@station_b)
    expect(@route.stations.size).to eq(2)
  end

  it "can not delete station if it not exist in list" do
    expect(@route.delete_station(@station_d)).to eq('No such station')
  end

  it "can not delete first station" do
    expect(@route.delete_station(@station_a)).to eq('Can NOT delete first station')
  end

  it "can not delete last station" do
    expect(@route.delete_station(@station_c)).to eq('Can NOT delete last station')
  end

  it "can display stations" do
    expect(@route.stations_info.join('. ')).to include("1.")
  end

end
