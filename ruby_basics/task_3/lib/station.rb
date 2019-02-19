require_relative "messages"
require_relative "instance_counter"
require_relative "validations"

class Station
  include InstanceCounter
  include Validations
  include Messages::Station
  attr_reader :name, :trains
  validates :name, :presence => true, :format => /[\S]+/i

  def initialize(name)
    @name = name
    @trains = []
    validate!
    register_instance
  end

  def self.all
    instances
  end

  def receive_train(train)
    return train_already_on_station if @trains.include?(train)
    @trains << train
    puts "#{train.info} ARRIVED to station #{self.info}"
    self
  end

  def dispatch_train(train)
    return no_such_train_on_station unless @trains.include?(train)
    @trains.delete(train)
    puts "#{train.info} DEPARTED from station #{self.info}"
    self
  end

  def display
    puts self.info
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
    "ст.#{self.name}"
  end

end
