require_relative "messages"
require_relative "instance_counter"
require_relative "validations"

class Route
  include Validations
  include InstanceCounter
  include Messages::Route
  attr_accessor :name
  attr_reader :stations
  validates :name, presence: true, uniqueness: true

  def initialize(name, first_station, last_station)
    @name = name
    @stations = [first_station, last_station]
    validate!
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
    self
  end

  def delete_station(station)
    return no_such_station unless @stations.include?(station)
    return can_not_delete_first_station if @stations.first == station
    return can_not_delete_last_station if  @stations.last == station
    @stations.delete(station)
    self
  end

  def stations_info
    @stations.map.with_index(1) { |s, i| "#{i}. #{s.info}"  }
  end

  def info
    "#{self.name}: " + @stations.map.with_index(1) { |s, i| "#{i}. #{s.info}"  }.join(" -> ")
  end
end
