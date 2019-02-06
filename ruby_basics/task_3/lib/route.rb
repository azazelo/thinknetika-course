require_relative "messages"

class Route
  include Messages::Route
  attr_reader :stations

  def initialize(first_station, last_station)
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
    @stations.map.with_index { |s, i| "#{i+1}. #{s.info}"  }
  end
end
