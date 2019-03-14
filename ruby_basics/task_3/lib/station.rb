require_relative 'base'
class Station < Base
  attr_reader :name, :trains
  validates :name, presence: true, format: /[\S]+/i, uniqueness: true

  def initialize(name)
    @name = name
    @trains = []
    validate!
    register_instance
  end

  def self.all
    instances
  end

  def each_train
    @trains.each { |train| yield(train) }
  end

  def receive_train(train)
    return Station.train_already_on_station if trains.include?(train)

    trains << train
    puts "#{train.info} ARRIVED to station #{info}"
    self
  end

  def dispatch_train(train)
    return Station.no_such_train_on_station unless trains.include?(train)

    @trains.delete(train)
    puts "#{train.info} DEPARTED from station #{info}"
    self
  end

  def display
    puts info
    puts 'Поезда на станции станции:'
    puts train_list(@trains)
  end

  def train_list(trains)
    trains.map.with_index(1) { |t, i| "#{i}. #{t.info}" }
  end

  def train_list_by_type(train_type)
    train_list(
      @trains.select { |t| t.type == train_type }
    )
  end

  def info
    "ст.#{name}"
  end
end
