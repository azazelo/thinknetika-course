require 'route'
require 'station'
require 'messages'
include Messages::Route

describe Route do
  let(:station_a) { Station.new(rand(Time.now.to_i).to_s) }
  let(:station_b) { Station.new(rand(Time.now.to_i).to_s) }
  let(:station_c) { Station.new(rand(Time.now.to_i).to_s) }
  let(:station_d) { Station.new(rand(Time.now.to_i).to_s) }

  let(:route) { Route.new("1", station_a, station_c) }

  it "should be created with name, first stations and last station" do
    expect(route.name).to eq("1")
    expect(route.stations.first).to eq(station_a)
    expect(route.stations.last).to eq(station_c)
  end

  it "can add station to list" do
    route.add_station(station_b)
    expect(route.stations.size).to eq(3)
    expect(route.stations[-2]).to eq(station_b)
  end

  it "can delete station from list" do
    route.delete_station(station_b)
    expect(route.stations.size).to eq(2)
  end

  it "can not delete station if it not exist in list" do
    expect(route.delete_station(station_d)).to include(no_such_station)
  end

  it can_not_delete_first_station do
    expect(route.delete_station(station_a)).to include(can_not_delete_first_station)
  end

  it "can not delete last station" do
    expect(route.delete_station(station_c)).to include(can_not_delete_last_station)
  end

  it "can display stations" do
    expect(route.stations_info.join('. ')).to include("1.")
  end

end
