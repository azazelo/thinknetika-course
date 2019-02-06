require_relative "route"
require_relative "station"
require_relative "message"

class Train
  include Message

  attr_accessor :speed, :route, :wagon_qty, :current_station
  attr_reader :current_position, :number, :type

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
    return can_not_add_wagon unless self.speed.zero?
    self.wagon_qty += 1
  end

  def remove_wagon
    return can_not_remove_wagon unless self.speed.zero?
    self.wagon_qty -= 1
  end

  def accept(route)
    self.route = route
    @current_station = self.route.stations.first
  end

  def go_forward
    return there_is_no_route + add_route unless self.route
    return at_last_station unless self.next_station
    return speed_is_zero if self.speed.zero?
    self.current_station.dispatch_train(self)
    @current_station = self.next_station.receive_train(self)
    self
  end


  def go_backward
    return there_is_no_route + add_route unless self.route
    return at_first_station unless self.previous_station
    return speed_is_zero if self.speed.zero?
    self.current_station.dispatch_train(self)
    @current_station = self.previous_station.receive_train(self)
    self
  end

  def get_station(position)
    return there_is_no_route + add_route unless self.route
    case position
    when 'next'
      return self.next_station if self.next_station
      no_next_station
    when 'previous'
      return self.previous_station if self.previous_station
      no_previous_station
    when 'current'
      self.current_station
    end
  end

  def info
    "Train (##{self.number}, type: '#{self.type}'', wagons: #{wagon_qty}, speed: #{speed})"
  end

  def previous_station
    return nil if self.current_position.zero?
    route.stations[self.current_position - 1]
  end

  def next_station
    return nil if self.current_position == self.route.stations.size - 1
    route.stations[self.current_position + 1]
  end

  def current_position
    route.stations.index(self.current_station)
  end
end
