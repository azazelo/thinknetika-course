class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def receive_train(train)
    return "This train already on station." if @trains.include?(train)
    @trains << train
    puts "#{train.info} ARRIVED to station #{self.info}"
    self
  end

  def dispatch_train(train)
    return "No such train on station." unless @trains.include?(train)
    @trains.delete(train)
    puts "#{train.info} DEPARTED from station #{self.info}"
    self
  end

  def display
    puts self.info
    puts 'trains on station:'
    puts train_list(@trains)
  end

  def train_list(trains)
    trains.map.with_index { |t, i| "#{i+1}. #{t.info}" }
  end

  def train_list_by_type(train_type)
    train_list(
      @trains.select { |t| t.type == train_type }
    )
  end

  def info
    "Station #{self.name}."
  end
end
