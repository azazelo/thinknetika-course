require 'station'

describe Station do
  before(:each) do
    @station = Station.new("A")
    @train = Train.new("001", "Cargo", 50)
    @station.receive_train(@train)
  end

  it "should be created with name A" do
    expect(@station.name).to eq('A')
  end

  it "can receive train" do
    expect(@station.trains.size).to eq(1)
  end

  it "can dispatch train" do
    @station.dispatch_train(@train)
    expect(@station.trains.size).to eq(0)
  end

  it "can return train list" do
    expect(@station.train_list([@train]).join('. ')).to include("1.")
  end

  it "can return train list by type" do
    expect(@station.train_list_by_type("Cargo").join('. ')).to include("1.")
  end

end
