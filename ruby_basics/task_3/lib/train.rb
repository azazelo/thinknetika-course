require_relative 'base'
class Train < Base
  attr_accessor :speed, :route, :current_station, :wagons, :number, :type
  attr_writer :current_position
  validates :number,
            presence: true, format: /[\w\d]{3}[-|]?[\w]{2}/i, uniqueness: true
  validates :type, presence: true, inclusion: Types::ALL

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    validate!
    register_instance
  end

  def each_wagon
    @wagons.each { |wagon| yield(wagon) }
  end

  def increase_speed(num)
    self.speed += num
    self
  end

  def stop
    self.speed = 0
    self
  end

  def add_wagon(wagon)
    return Train.wagon_already_added if @wagons.include?(wagon)
    return Train.wagon_has_incompatible_type unless type == wagon.type
    return Train.speed_is_not_zero unless speed.zero?

    @wagons << wagon
    self
  end

  def remove_wagon(wagon_number)
    return Train.speed_is_not_zero unless speed.zero?

    wagon = wagons.detect { |w| w.number == wagon_number }
    return Train.wagon_not_in_list unless wagons.include?(wagon)

    wagons.delete(wagon)
    self
  end

  def accept(route)
    @route = route
    @current_station = route.stations.first
    @current_position = 0
    @route.stations.first.receive_train(self)
    self
  end

  def go_forward
    res = can_go_forward?
    return res if res.is_a?(String)

    current_station.dispatch_train(self)
    next_station.receive_train(self)
    @current_station = next_station
    @current_position = route.stations.index(current_station)
    self
  end

  def can_go_forward?
    return Train.there_is_no_route + Train.add_route unless route
    return Train.at_last_station unless next_station
    return Train.speed_is_zero if speed.zero?

    true
  end

  def go_backward
    return Train.there_is_no_route + Train.add_route unless route
    return Train.at_first_station unless previous_station
    return Train.speed_is_zero if speed.zero?

    @current_station = previous_station
    self
  end

  def get_station(position)
    return Train.there_is_no_route + Train.add_route unless route
    return next_station || Train.no_next_station if position == 'next'
    return previous_station || Train.no_previous_station if
      position == 'previous'

    current_station
  end

  def info
    "Поезд ##{number}:
       Тип: #{type}
       Маршрут: #{route ? route.info : 'Пока не задан.'}
       Текущая станция: #{current_station_info}
       Вагоны(#{wagons.size}):
        #{wagons_info}"
  end

  def wagons_info
    return 'Вагонов нет. Только локомотив.' if wagons.empty?

    wagons.map(&:info).join("\n\t")
  end

  def current_station_info
    current_station ? current_station.info : 'Пока не задана.'
  end

  def previous_station
    return if current_position.zero?

    route.stations[current_position - 1]
  end

  def next_station
    return if current_position == route.stations.size - 1

    route.stations[current_position + 1]
  end

  def current_position
    route.stations.index(current_station)
  end
end
