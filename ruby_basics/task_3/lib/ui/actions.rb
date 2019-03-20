module UI
  module Actions
    def self.included(base)
      base.extend ClassMethodsForTrains
      base.extend ClassMethodsForRoutes
      base.extend ClassMethodsForStations
      base.extend ClassMethodsForWagons
      base.extend ClassMethods
    end

    module ClassMethodsForTrains
      def edit_trains(opts = {})
        res = choose_train(opts)
        return res if res.is_a?(String)

        train = res
        command = (menu = edit_trains_menu(train)).show.command
        return if command == '0'

        menu.handle_command(command, train, opts[:routes])
        train
      end

      def create_train
        loop do
          chosen_type = choose_train_type
          next unless chosen_type

          train = train_klass(chosen_type).new(input_train_number)
          puts "> Успешно создан #{train.info}."
          return train
        end
      end

      def show_trains(opts = {})
        return '> Еще не создано ни одного поезда.' if opts[:trains].empty?

        options_for(
          title: 'Поезда:',
          array: opts[:trains],
          show_prompt: 'no'
        )
      end

      def add_wagon_to_train(train)
        loop do
          wagon_num = input_new_wagon_number(train)
          return 'Ошибка' unless wagon_num

          train.add_wagon(wagon_klass(train).new(wagon_num, input_value(train)))
          puts "> Вагон #{wagon_num} добавлен в состав #{train.info}."
          next if repeat?

          return train
        end
      end

      def remove_wagon_from_train(train)
        return '> Нет вагонов в составе поезда.' if train.wagons.empty?

        res = choose_wagon(train)
        return res if res.is_a?(String)

        train.remove_wagon(res.number)
        puts "> Вагон ##{res.number} успешно удален из состава #{train.info}."
      end

      def assign_route_to_train(train, routes)
        return '> Нет маршрутов в системе.' if routes.empty?

        res = choose_route(routes: routes)
        return '> Маршрут не выбран.' if res.is_a?(String)

        route = res
        train.accept(route)
        puts "> Маршрут успешно назначен поезду #{train.info}."
        train
      end

      def repeat?
        print 'Повторить ? 1 - Да, 2 -  Нет: '
        command = gets.strip
        return true if command == '1'
        return false if command == '2'
      end

      def choose_wagon(train)
        options_for(
          title: '> Вагоны, включённые в состав поезда:',
          array: train.wagons
        )
        wagon = train.wagons[gets.strip.to_i - 1]
        puts '> Такого вагона нет в составе поезда.' unless wagon
        return false unless wagon

        wagon
      end

      def move_trains(opts)
        return '> Не создано ни одного поезда.' if opts[:trains].empty?

        res = choose_train(opts)
        return '> Поезд не выбран.' if res.is_a?(String)

        train = res
        return '> У поезда нет маршрута.' unless train.route

        move_train_menu.show.handle_command(gets.strip, train)
        train
      end

      def choose_train(opts = {})
        return '> Нет ни одного поезда в системе. Создайте поезд.' if
          opts[:trains].empty?

        options_for(title: 'Поезда:', array: opts[:trains])
        train = opts[:trains][gets.strip.to_i - 1]
        return '> Неправильно набран номер.' unless train

        puts "Поезд : #{train.info}"
        train
      end
    end

    module ClassMethodsForStations
      def create_station(opts = {})
        loop do
          options_for_if(opts[:stations].any?, title: 'Станции:',
                                               array: opts[:stations],
                                               show_prompt: 'no')
          print 'Введите наименование новой станции: '
          station = Station.new(gets.strip)
          puts "> Успешно создна станция #{station.name}."
          return station
        end
      end

      def show_stations(opts = {})
        options_for(title: 'Станции:', array: opts[:stations],
                    prompt: 'Введите номер станции (если есть) в списке
для просмотра поездов на этой станции, 0 - для выхода: ')
        command = gets.strip
        return if command == '0'

        station = opts[:stations].at(command.to_i - 1)
        return 'Неправильный ввод! Повторите сначала.' unless station

        puts station.trains.any? ? station.display : '> Нет поездов на станции.'
      end
    end

    module ClassMethodsForRoutes
      def create_route(opts = {})
        loop do
          route =
            Route.new(input_route_name(opts),
                      first_station = choose_first_station(opts[:stations]),
                      choose_last_station(opts[:stations] - [first_station]))
          next unless route

          puts "> Успешно создан маршрут #{route.info}." if route
          next if repeat?

          return route
        end
      end

      def choose_first_station(stations)
        puts 'Выбор ПЕРВОЙ станции маршрута: '
        choose_station(stations)
      end

      def choose_last_station(stations)
        puts 'Выбор ПОСЛЕДНЕЙ станции маршрута: '
        choose_station(stations)
      end

      def can_create_route?(opts)
        if opts[:stations].size.zero?
          puts '> Нет станций. Создайте по крайней мере две станции.'
          return false
        end
        if opts[:stations].size == 1
          puts '> Только одна станция в системе. Нужны две станции.'
          return false
        end
        true
      end

      def input_route_name(opts)
        loop do
          print 'Введите наименование маршрута: '
          route_name = gets.strip
          if any_item?(opts[:routes], 'name', route_name)
            puts '> Такой маршрут уже есть. Повторите ввод.'
            next
          end
          return route_name
        end
      end

      def show_routes(opts = {})
        return '> Еще не создано ни одного маршрута. Создайте маршрут.' if
          opts[:routes].empty?

        options_for(
          title: 'Маршруты:',
          array: opts[:routes],
          show_prompt: 'no'
        )
      end

      def edit_route(opts = {})
        res = choose_route(opts)
        return '> Маршрут не выбран.' if res.is_a?(String)

        route = res
        edit_route_menu.show.handle_command(gets.strip, route, opts[:stations])
        route
      end

      def choose_route(opts = {})
        if opts[:routes].empty?
          return '> Нет маршрутов в системе. Создайте маршруты.'
        end

        options_for(title: 'Маршруты:', array: opts[:routes])
        route = opts[:routes][gets.strip.to_i - 1]
        return '> Неправильно набран номер.' unless route

        route
      end

      def add_station_to_route(route, stations)
        options_for(title: 'Станции уже включённые маршрут:',
                    array: route.stations)
        stations_can_be_added = stations - route.stations
        return '> Нет станций для добавления.' if stations_can_be_added.empty?

        station = choose_station_to_add(stations_can_be_added)
        return '> Неправильно набран номер.' unless station

        stations << station
        route.add_station(station)
        puts "> Станция успешно добавлена в маршрут. #{route.info}"
      end

      def choose_station_to_add(stations_can_be_added)
        options_for(
          title: 'Станции, для добавления:',
          array: stations_can_be_added,
          prompt: 'Введите номер станции, которую хотите добавить в маршрут: '
        )
        stations_can_be_added.at(gets.strip.to_i - 1)
      end

      def remove_station_from_route(route, _stations)
        return Route.not_enough_stations if route.stations_to_remove.empty?

        station = choose_station_to_delete(route)
        return 'Такой станции нет.' unless station

        route.delete_station(station) if station
        puts "Станция успешно удалена из маршрута. #{route.info}" if station
        station
      end

      def choose_station_to_delete(route)
        options_for(title: 'Станции для удаления:',
                    array: route.stations_to_remove)
        print 'Введите Номер станции, которую хотите удалить из маршрута: '
        route.stations_to_remove.at(gets.strip.to_i - 1)
      end
    end

    module ClassMethodsForWagons
      def wagon_klass(train)
        train.cargo? ? CargoWagon : PassengerWagon
      end

      def load_unload_wagon(train)
        loop do
          command = (menu = menu_load_unload_wagon(train)).show.command
          break if command == '0'

          wagon = choose_wagon(train)
          next unless wagon

          res = menu.handle_command(command, wagon)
          next unless res

          repeat? ? next : break
        end
      end
    end

    module ClassMethods
      def choose_station(stations)
        loop do
          options_for(title: 'Станции:', array: stations,
                      text_on_empty: '> Нет станций. Создайте станции.')
          choise = gets.strip.to_i
          next unless choise_ok?(choise, stations)

          station = stations[choise - 1]
          puts "> Выбрана станция : #{station.info}"
          return station
        end
      end

      def choise_ok?(choise, array)
        if choise.zero? || choise > array.size
          puts '> Неправильно набран номер. Повторите ввод.'
          return false
        end
        true
      end

      def any_item?(array, field_name, value)
        array.detect { |item| item.send(field_name) == value }
      end

      def choose_train_type
        print 'Введите 1 для создания пассажирского, 2 - грузового поезда: '
        chosen_type = gets.strip
        unless %w[1 2].include?(chosen_type)
          puts 'Неправильный выбор типа поезда! Повторите сначала.
Необходимо ввести цифру 1 или 2.'
          return false
        end
        chosen_type
      end

      def input_train_number
        print 'Введите номер поезда
(формат: 3 буквы/цифры + возможно дефис + 2 буквы или цифры): '
        gets.strip
      end

      def train_klass(chosen_type)
        return PassengerTrain if chosen_type == '1'
        return CargoTrain if chosen_type == '2'
      end

      def input_new_wagon_number(train)
        loop do
          options_for(title: '> Вагоны поезда:',
                      array: train.wagons,
                      text_on_empty: 'Нет вагонов в составе поезда',
                      prompt: 'Введите номер или наименование нового вагона: ')
          wagon_number = gets.strip
          has_wagon = any_item?(train.wagons, 'number', wagon_number)
          puts ">> Вагон #{wagon_number} уже есть. Повторите ввод." if has_wagon
          return wagon_number unless has_wagon
        end
      end

      def input_value(train)
        print '> Введите грузоподъемность вагона (кг.): ' if train.cargo?
        print '> Введите количество мест в вагоне: ' if train.passenger?
        gets.strip.to_i
      end

      def options_for_if(cond, opts = {})
        cond ? options_for(opts) : (puts opts[:text_on_empty])
      end

      def options_for(opts = {})
        puts opts[:title]
        puts opts[:text_on_empty] ||= 'Нет элементов в системе.' if
          opts[:array].empty?
        puts_array(opts) if opts[:array].any?
        print opts[:prompt] ||= 'Введите номер из списка: ' if
          (opts[:show_prompt] ||= 'yes') == 'yes'
      end

      def puts_array(opts)
        opts[:field_name] ||= 'info'
        list = opts[:array].map.with_index(1) do |item, item_index|
          "#{item_index} - #{item.send(opts[:field_name])}"
        end.join("\n")
        puts list
      end
    end
  end
end
