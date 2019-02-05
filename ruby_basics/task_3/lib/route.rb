class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
    self
  end

  def delete_station(station)
    return "No such station" unless @stations.include?(station)
    return "Can NOT delete first station" if @stations.first == station
    return "Can NOT delete last station" if  @stations.last == station
    @stations.delete(station)
    self
  end

  def stations_info
    @stations.map.with_index { |s, i| "#{i+1}. #{s.info}"  }
  end

  def message(str)
    str
  end
end
