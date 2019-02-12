require_relative "route"
require_relative "station"
require_relative "messages"
require_relative "types"

class Train
  include Types
  include Messages::Train

  attr_accessor :speed, :route, :current_station
  attr_reader :current_position, :number, :type, :wagons

  def initialize(number)
    @number = number
    @speed = 0
    @route = nil
    @current_position = nil
    @wagons = []
  end

  def increase_speed(num)
    self.speed += num
  end

  def stop
    self.speed = 0
  end

  def add_wagon(wagon)
    puts self.type
    return can_not_add_wagon + wagon_already_added if @wagons.include?(wagon)
    return can_not_add_wagon + wagon_has_incompatible_type unless self.type == wagon.type
    return can_not_add_wagon + speed_is_not_zero unless self.speed.zero?
    @wagons << wagon
    self
  end

  def remove_wagon(wagon_number)
    return can_not_remove_wagon + speed_is_not_zero unless self.speed.zero?
    wagon = @wagons.select { |w| w.number == wagon_number }.first
    return can_not_remove_wagon + wagon_not_in_list unless @wagons.include?(wagon)
    @wagons.delete(wagon)
    self
  end

  def accept(route)
    self.route = route
    @current_station = self.route.stations.first
    self
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
      self.next_station ? self.next_station : no_next_station
    when 'previous'
      self.previous_station ? self.previous_station : no_previous_station
    when 'current'
      self.current_station
    end
  end

  def info
    "Поезд ##{self.number}:
      Тип: #{self.type}
      Вагоны(#{@wagons.size}): #{@wagons.any? ? @wagons.map(&:info).join(', ') : "Вагонов нет. Только локомотив."}
      Маршрут: #{self.route ? self.route.info : 'Пока не задан.'}"
  end

  def previous_station
    return if self.current_position.zero?
    route.stations[self.current_position - 1]
  end

  def next_station
    return if self.current_position == self.route.stations.size - 1
    route.stations[self.current_position + 1]
  end

  def current_position
    route.stations.index(self.current_station)
  end
end
