class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def receive_train(train)
    @trains << train
  end

  def display_trains
    puts "Station name is #{self.name}"
    puts "  trains: "
    puts @trains.map { |t| t.number }
  end

  def display_trains_by_type(train_type)
    puts @trains.select { |t| t.type == train_type }
  end

  def dispatch_train(train)
    @trains.delete(train)
  end

end

class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end
end

class Train
  attr_accessor :speed, :route, :wagon_qty
  attr_reader :current_position, :current_station

  def initialize(number, type, wagon_qty)
    @number = number
    @type = type
    @wagon_qty = wagon_qty
    @speed = 0
    @route = nil
    @current_position = nil
  end

  def increase_speed(num)
    self.speed += num
  end

  def stop
    self.speed = 0
  end

  def add_wagon
    return message_can_not_add_wagon unless self.speed.zero?
    # self.wagon_qty += 1
  end

  def delete_wagon
    return message_can_not_delete_wagon unless self.speed.zero?
    self.wagon_qty -= 1
  end

  def receive_route(route)
    self.route = route
    @current_station = self.route.stations.first
  end

  def go_forward
    return "There is NO route. Add route first." unless self.route
    self.current_station.dispatch_train
    return @current_station = self.next_station.receive_train if self.next_station
    message_at_last_station
  end


  def go_backward
    return "There is NO route. Add route first." unless self.route
    self.current_station.dispatch_train
    return @current_station = self.previous_station.receive_train if self.previous_station
    message_at_first_station
  end

  def get_station(position)
    return "There is NO route. Add route first." unless self.route
    case position
    when 'next'
      return self.next_station if self.next_station
      message_at_last_station
    when 'previous'
      return self.previoû_station if self.previous_station
      message_at_first_station
    when 'current'
      self.current_station
    end
  end

  private

  def previous_station
    route.stations[self.current_position - 1]
  end

  def next_station
    route.stations[self.current_position + 1]
  end

  def current_position
    route.stations.index(self.current_station)
  end

  def message_can_add_delete_wagon
    "Can not add wagon if train moving. Speed is #{self.speed}. Stop train first."
  end

  def message_can_not_delete_wagon
    "Can not delete wagon if train moving. Speed is #{self.speed}. Stop train first."
  end

  def message_no_next_station
    "There is NO next station!"
  end

  def message_no_previous_station
    "There is NO previous station!"
  end

  def message_at_first_station
    "Can not go backward: At FIRST station!"
  end

  def message_at_last_station
    "Can not go forward: At LAST station!"
  end

end
