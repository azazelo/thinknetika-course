require_relative "route"
require_relative "station"

class Train
  attr_accessor :speed, :route, :wagon_qty
  attr_reader :current_position, :current_station, :number, :type

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
    self.wagon_qty += 1
  end

  def remove_wagon
    return message_can_not_remove_wagon unless self.speed.zero?
    self.wagon_qty -= 1
  end

  def accept(route)
    self.route = route
    @current_station = self.route.stations.first
  end

  def go_forward
    return "There is NO route. Add route first." unless self.route
    if self.next_station
      return puts "Speed is zero. Can not go forward. Increase speed." if self.speed.zero?
      self.current_station.dispatch_train(self)
      return @current_station = self.next_station.receive_train(self)
    else
      message_at_last_station
    end
    self
  end


  def go_backward
    return "There is NO route. Add route first." unless self.route
    if self.previous_station
      self.current_station.dispatch_train(self)
      return @current_station = self.previous_station.receive_train(self)
    else
      message_at_first_station
    end
    self
  end

  def get_station(position)
    return puts "There is NO route. Add route first." unless self.route
    case position
    when 'next'
      return self.next_station if self.next_station
      message_no_next_station
    when 'previous'
      return self.previous_station if self.previous_station
      message_no_previous_station
    when 'current'
      self.current_station
    end
  end

  def info
    "Train (##{self.number}, type: '#{self.type}'', wagons: #{wagon_qty}, speed: #{speed})"
  end

  def previous_station
    return nil if self.current_position == 0
    route.stations[self.current_position - 1]
  end

  def next_station
    return nil if self.current_position == self.route.stations.size - 1
    route.stations[self.current_position + 1]
  end

  def current_position
    route.stations.index(self.current_station)
  end

  def message_can_add_remove_wagon
    "Can not add wagon if train moving. Speed is #{self.speed}. Stop train first."
  end

  def message_can_not_remove_wagon
    "Can not remove wagon if train moving. Speed is #{self.speed}. Stop train first."
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
