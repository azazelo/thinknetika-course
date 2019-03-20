require_relative 'base'

class Route < Base
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
    return Route.has_this_station if stations.include?(station)

    @stations.insert(-2, station)
    self
  end

  def delete_station(station)
    return Route.no_such_station unless @stations.include?(station)
    return Route.can_not_delete_first_station if @stations.first == station
    return Route.can_not_delete_last_station if  @stations.last == station

    @stations.delete(station)
    self
  end

  def stations_info
    @stations.map.with_index(1) { |s, i| "#{i}. #{s.info}" }
  end

  def stations_to_remove
    @stations[1, @stations.size - 2]
  end

  def info
    "#{name}: " + @stations.map.with_index(1) do |s, i|
      "#{i}. #{s.info}"
    end.join(' -> ')
  end
end
