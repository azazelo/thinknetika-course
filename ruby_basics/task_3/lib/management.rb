# - Создавать станции
# - Создавать поезда
# - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
# - Назначать маршрут поезду
# - Добавлять вагоны к поезду
# - Отцеплять вагоны от поезда
# - Перемещать поезд по маршруту вперед и назад
# - Просматривать список станций и список поездов на станции

def menu
  stations = []
  routes = []
  trains = []
  seed(stations, routes, trains)
  loop do
    system('clear')
    puts "============ Железная дорога =============="
    puts "1 - Создать станцию."
    puts "2 - Просмотр станций."
    puts "3 - Создать поезд."
    puts "4 - Вывести список поездов."
    puts "5 - Изменить состав и маршрут поезда."
    puts "6 - Создать маршрут."
    puts "7 - Вывести список маршрутов."
    puts "8 - Редактировать маршрут."
    puts "9 - Двигать поезд по маршруту."
    puts "0 - Выход."
    print ": "

    command = gets.strip
    case command
    when "0" then break
    when "1" then (res = create_station(stations)).is_a?(String) ? (puts res; next) : (stations << res)
    when "2" then (res = show_stations(stations)).is_a?(String) ? (puts res) : res
    when "3" then (res = create_train).is_a?(String) ? (puts res) : (trains << res)
    when "4" then show_trains(trains)
    when "5" then res = edit_trains(trains, routes); puts res if res.is_a?(String)
    when "6" then (res = create_route(routes, stations)).is_a?(String) ? (puts res) : (routes << res)
    when "7" then show_routes(routes)
    when "8" then puts edit_route(routes, stations)
    when "9" then puts move_trains(routes, trains)
    end

    print ">> Нажмите любую клавишу для продолжения..."
    gets.strip
  end
end

def create_train
  loop do
    print "Введите номер поезда: "
    number = gets.strip
    print "Введите 1 для создания пассажирского, 2 для создания грузового поезда: "
    puts chosen_type = gets.strip
    (puts "Неправильный выбор типа поезда! Повторите сначала. Необходимо ввести цифру 1 или 2."; next) unless %w[1 2].include?(chosen_type)
    klass = PassengerTrain if chosen_type == "1"
    klass = CargoTrain if chosen_type == "2"
    begin
      train = klass.new(number)
      puts "> Успешно создан #{train.info}."
      return train
    rescue RuntimeError => e
      puts e.inspect
      puts "> Повторите ввод."
    end
  end
end

def show_trains(trains)
  puts trains.empty? ? "> Еще не создано ни одного поезда." : options_for("Поезда:", trains)
end

def create_station(stations)
  loop do
    puts stations.any? ? options_for("Станции в системе:", stations) : "В системе нет станций."
    print "Введите наименование новой станции: "
    station_name = gets.strip
    begin
      station = Station.new(station_name)
      puts "> Успешно создна станция #{station_name}."
      return station
    rescue RuntimeError => e
      puts e.inspect
      puts "> Повторите ввод."
    end
  end
end

def show_stations(stations)
  return "> Еще не создано ни одной станции." if stations.empty?
  puts options_for("Станции:", stations)
  print "Введите номер станции в списке для просмотра поездов на этой станции, 0 - для выхода: "
  command = gets.strip
  return if command == "0"
  station = stations.at(command.to_i - 1)
  return "Неправильный ввод! Повторите сначала." unless station
  puts station.trains.any? ? station.display : "> Нет поездов на станции."
end

def create_route(routes, stations)
  loop do
    return "> Невозможно создать маршрут. В системе нет станций. Создайте по крайней мере две станции." if stations.size < 2
    print "Введите наименование маршрута: "
    route_name = gets.strip
    (puts "> Наименование маршрута не может быть пустым. Повторите ввод."; next) if route_name.empty?
    (puts "> Такой маршрут уже есть. Повторите ввод."; next) if any_item?(routes, 'name', route_name)

    begin

      puts "Выбор ПЕРВОЙ станции маршрута: "
      res = choose_station(stations)
      (puts res; next) if res.is_a?(String)
      first_station = res
      puts "Выбор ПОСЛЕДНЕЙ станции маршрута: "
      res = choose_station(stations)
      (puts res; next) if res.is_a?(String)
      last_station = res

      route = Route.new(route_name, first_station, last_station)
      puts "> Успешно создан маршрут #{route.info}."
      return route
    rescue RuntimeError => e
      puts e.inspect
      puts "> Повторите ввод."
    end
  end
end

def show_routes(routes)
  puts routes.empty? ? "> Еще не создано ни одного маршрута. Создайте маршрут." : options_for("Маршруты:", routes)
end

def edit_route(routes, stations)
  res = choose_route(routes)
  return "> Маршрут не выбран." if res.is_a?(String)
  route = res
  puts "1 - добавить станцию в маршрут."
  puts "2 - удалить станцию из маршрута."
  command = gets.strip
  case command
  when "1"
    res = add_station_to_route(route, stations)
    return res if res.is_a?(String)
  when "2"
    res = remove_station_from_route(route, stations)
    return res if res.is_a?(String)
  end
  route
end

def choose_route(routes)
  return "> Нет ни одного маршрута в системе. Создайте маршруты." if routes.empty?
  puts "Маршруты: "
  puts options_for("Маршруты:", routes)
  print "Введите номер из списка: "
  route = routes[gets.strip.to_i - 1]
  return "> Неправильно набран номер." unless route
  route
end

def add_station_to_route(route, stations)
  puts options_for("Станции уже включённые маршрут:", route.stations)
  stations_can_be_added = stations - route.stations
  return "> Нет станций для добавления." if stations_can_be_added.empty?
  puts options_for("Станции которые можно добавить в маршрут:", stations_can_be_added)
  print "Введите Номер станции из списка, которую хотите добавить в маршрут: "
  station = stations_can_be_added.at(gets.strip.to_i - 1)
  return "> Неправильно набран номер." unless station
  stations << station
  route.add_station(station)
  puts "> Станция успешно добавлена в маршрут. #{route.info}"
end

def remove_station_from_route(route, stations)
  stations_can_be_removed = route.stations[1, route.stations.size - 2]
  return "> В маршруте только начальная и конечная станции. Нельзя удалить ни одной станции." if stations_can_be_removed.empty?
  puts options_for("Станции, которые можно удалить из маршрута:", stations_can_be_removed)
  print "Введите Номер станции из списка, которую хотите удалить из маршрута: "
  station = stations_can_be_removed.at(gets.strip.to_i - 1)
  if station
    route.delete_station(station)
    puts "Станция успешно удалена из маршрута. #{route.info}"
  else
    puts "Такой станции нет."
  end
end

def edit_trains(trains, routes)
  res = choose_train(trains)
  return "> Поезд не выбран." if res.is_a?(String)
  train = res
  puts "1 - добавить вагон в состав поезда,"
  puts "2 - удалить вагон из состава поезда,"
  puts "3 - назначить маршрут поезду."
  command = gets.strip
  case command
  when "1"
    res = add_wagon_to_train(train)
    return res if res.is_a?(String)
  when "2"
    res = remove_wagon_from_train(train)
    return res if res.is_a?(String)
  when "3"
    res = assign_route_to_train(train, routes)
    return res if res.is_a?(String)
  end
  train
end

def add_wagon_to_train(train)
  puts options_for("> Вагоны уже включённые в состав поезда:", train.wagons) if train.wagons.any?
  print "Введите номер нового вагона: "
  wagon_number = gets.strip
  return "> Вагон с номером #{wagon_number} уже есть в составе поезда" if any_item?(train.wagons, 'number', wagon_number)
  klass = CargoWagon if train.type == Types::CARGO
  klass = PassengerWagon if train.type == Types::PASSENGER
  wagon = klass.new(wagon_number)
  train.add_wagon(wagon)
  puts "> Вагон номер #{wagon_number} успешно добавлен в состав поезда #{train.info}."
end

def remove_wagon_from_train(train)
  return "> Нет вагонов в составе поезда." if train.wagons.empty?
  puts options_for("> Вагоны уже включённые в состав поезда:", train.wagons)
  print "Введите номер из списка: "
  wagon_number = gets.strip.to_i
  wagon = train.wagons[wagon_number - 1]
  return "> Такого вагона нет в составе поезда." unless wagon
  train.remove_wagon(wagon.number)
  puts "> Вагон ##{wagon.number} успешно удален из состава поезда #{train.info}."
end

def assign_route_to_train(train, routes)
  return "> Нет маршрутов в системе." if routes.empty?
  res = choose_route(routes)
  return "> Маршрут не выбран." if res.is_a?(String)
  route = res
  train.accept(route)
  puts "> Маршрут успешно назначен поезду #{train.info}."
  train
end

def move_trains(routes, trains)
  return "> Не создано ни одного поезда." if trains.empty?
  res = choose_train(trains)
  return "> Поезд не выбран." if res.is_a?(String)
  train = res
  return "> У поезда нет маршрута." unless train.route

  puts "1 - передвинуть поезд ВПЕРЕД по маршруту,"
  puts "2 - передвинуть поезд НАЗАД по маршруту."
  command = gets.strip
  case command
  when "1"
    train.speed = 10
    res = train.go_forward
    train.speed = 0
    return res if res.is_a?(String)
  when "2"
    train.speed = 10
    res = train.go_backward
    train.speed = 0
    return res if res.is_a?(String)
  end
  train
end

def choose_train(trains)
  return "> Нет ни одного поезда в системе. Создайте поезд." if trains.empty?
  puts "Поезда: "
  puts options_for("Trains:", trains)
  print "Введите номер из списка: "
  train = trains[gets.strip.to_i - 1]
  return "> Неправильно набран номер." unless train
  puts "Поезд : #{train.info}"
  train
end

def choose_station(stations)
  loop do
    return "> Нет ни одной станции в системе. Создайте станции." if stations.empty?
    puts options_for("Станции:", stations)
    print "Введите номер из списка: "
    choise = gets.strip.to_i
    (puts "> Неправильно набран номер. Повторите ввод."; next) if (choise.zero? || choise > stations.size)
    station = stations[choise - 1]
    puts "> Выбрана станция : #{station.info}"
    return station
  end
end

def options_for(title, array, field_name="info")
  ([title] + array.map.with_index(1) { |item, item_index|  "#{item_index} - #{item.send(field_name)}" })
  .join("\n")
end

def any_item?(array, field_name, value)
  array.select { |item| item.send(field_name) ==  value }.any?
end

def seed(stations, routes, trains)
  stations << Station.new("Москва")
  stations << Station.new("Астрахань")
  stations << Station.new("Волгоград")
  trains << PassengerTrain.new("001-99")
  routes << Route.new("111", stations[0], stations[1])
  trains[0].accept(routes[0])
  trains << CargoTrain.new("002-bb").accept(routes[0])
end
