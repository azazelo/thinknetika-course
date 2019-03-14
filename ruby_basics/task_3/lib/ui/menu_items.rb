require_relative 'actions'

module UI
  module MenuItems
    def self.included(base)
      base.extend ClassMethodsForStations
      base.extend ClassMethodsForTrains
      base.extend ClassMethodsForWagons
      base.extend ClassMethodsForRoutes
    end

    include UI::Actions

    module ClassMethodsForStations
      def menu_item_create_station
        [
          'Создать станцию.',
          proc do |opts|
            #            res = create_station(opts)
            #            puts res && next if res.is_a?(String)
            #            next if res.is_a?(String)

            opts[:stations] << create_station(opts)
          end
        ]
      end

      def menu_item_show_stations
        ['Просмотр станций.',
         proc do |opts|
           if opts[:stations].empty?
             puts '> Еще не создано ни одной станции.'
           else
             res = show_stations(opts)
             puts res if res.is_a?(String)
           end
         end]
      end
    end

    module ClassMethodsForTrains
      def menu_item_edit_trains
        [
          'Изменить состав и/или маршрут поезда.',
          proc do |opts|
            res = edit_trains(opts)
            puts res if res.is_a?(String)
          end
        ]
      end

      def menu_item_create_train
        [
          'Создать поезд.',
          proc do |opts|
            res = create_train
            res.is_a?(String) ? (puts res) : opts[:trains] << res
          end
        ]
      end

      def menu_item_show_trains
        [
          'Просмотр поездов.',
          proc do |opts|
            res = show_trains(opts)
            puts res
          end
        ]
      end

      def menu_item_add_wagon_to_train
        [
          'Добавить вагон в состав поезда.',
          proc do |train|
            res = add_wagon_to_train(train)
            puts res
            return res if res.is_a?(String)
          end
        ]
      end

      def menu_item_remove_wagon_from_train
        [
          'Удалить вагон из состава поезда,',
          proc do |train|
            loop do
              res = remove_wagon_from_train(train)
              puts res if res.is_a?(String)
              repeat? ? next : break
            end
          end
        ]
      end

      def menu_item_assign_route_to_train
        [
          'Назначить маршрут поезду.',
          proc do |train, routes|
            res = assign_route_to_train(train, routes)
            puts res if res.is_a?(String)
          end
        ]
      end

      def menu_item_move_train
        [
          'Передвинуть поезд по маршруту.',
          proc { |opts| puts move_trains(opts) }
        ]
      end

      def menu_item_move_train_forward
        [
          'Передвинуть поезд ВПЕРЕД по маршруту',
          proc do |train|
            train.speed = 10
            res = train.go_forward
            train.speed = 0
            return res if res.is_a?(String)
          end
        ]
      end

      def menu_item_move_train_backward
        [
          'Передвинуть поезд НАЗАД по маршруту.',
          proc do |train|
            train.speed = 10
            res = train.go_backward
            train.speed = 0
            return res if res.is_a?(String)
          end
        ]
      end
    end

    module ClassMethodsForWagons
      def menu_item_load_unload_wagon(train)
        [
          train.cargo? ? 'За(вы)грузить груз.' : 'Пос(выс)адить пассажира.',
          proc do |t|
            puts '> Нет вагонов в составе поезда.' if t.wagons.empty?
            load_unload_wagon(t)
          end
        ]
      end

      def menu_load_unload_wagon(train)
        train.cargo? ? manage_weight_menu : manage_passenger_menu
      end

      def menu_item_passenger_in
        [
          'Посадить пассажира в вагон.',
          proc do |wagon|
            res = wagon.push
            return res if res.is_a?(String)

            puts "> Успешно! Новое состояние вагона: #{wagon.info}."
            wagon
          end
        ]
      end

      def menu_item_passenger_out
        [
          'Высадить пассажира из вагон.',
          proc do |wagon|
            res = wagon.pull
            puts res if res.is_a?(String)
            next if res.is_a?(String)

            puts "> Успешно! Новое состояние вагона: #{wagon.info}."
            wagon
          end
        ]
      end

      def menu_item_unload_from_wagon
        [
          'Выгрузить груз из вагона.',
          proc do |wagon|
            wagon.pull(input_weight)
            puts res if res.is_a?(String)
            next if res.is_a?(String)

            puts "> Успешно! Новое состояние вагона: #{wagon.info}."
            wagon
          end
        ]
      end

      def menu_item_load_in_wagon
        [
          'Поместить груз в вагон.',
          proc do |wagon|
            res = wagon.push(input_weight)
            puts res if res.is_a?(String)
            next if res.is_a?(String)

            puts "> Успешно! Новое состояние вагона: #{wagon.info}."
            wagon
          end
        ]
      end

      def input_weight
        print 'Введите вес груза (кг.): '
        gets.strip.to_i
      end
    end

    module ClassMethodsForRoutes
      def menu_item_create_route
        [
          'Создать маршрут.',
          proc do |opts|
            if can_create_route?(opts)
              opts[:routes] << create_route(opts)
            else
              puts 'Нельзя создать маршрут!'
            end
          end
        ]
      end

      def menu_item_show_routes
        [
          'Просмотр маршрутов.',
          proc do |opts|
            res = show_routes(opts)
            puts res if res.is_a?(String)
            next if res.is_a?(String)
          end
        ]
      end

      def menu_item_edit_route
        [
          'Изменить маршрут.',
          proc { |opts| puts edit_route(opts) }
        ]
      end

      def menu_item_add_station_to_route
        [
          'Добавить станцию в маршрут',
          proc do |route, stations|
            res = add_station_to_route(route, stations)
            next if res.is_a?(String)
          end
        ]
      end

      def menu_item_remove_station_from_route
        [
          'Удалить станцию из маршрута.',
          proc do |route, stations|
            res = remove_station_from_route(route, stations)
            puts res if res.is_a?(String)
            next if res.is_a?(String)
          end
        ]
      end

      def menu_item_back
        ['Отмена. Возврат в предыдущее меню.', proc { return 'return' }]
      end
    end
  end
end
