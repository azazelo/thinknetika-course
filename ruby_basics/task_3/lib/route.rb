require_relative "messages"

class Route
  include Messages::Route
  attr_accessor :name
  attr_reader :stations

  def initialize(name, first_station, last_station)
    @name = name
    @stations = [first_station, last_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
    self
  end

  def delete_station(station)
    return no_such_station unless @stations.include?(station)
    return can_no_delete_first_station if @stations.first == station
    return can_no_delete_last_station if  @stations.last == station
    @stations.delete(station)
    self
  end

  def stations_info
    @stations.map.with_index(1) { |s, i| "#{i}. #{s.info}"  }
  end

  def info
    @stations.map.with_index(1) { |s, i| "#{i}. #{s.info}"  }
  end
end
