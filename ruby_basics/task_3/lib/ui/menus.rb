require_relative 'menu'
require_relative 'menu_items'
require_relative 'actions'
require_relative '../monkey_patching'

module UI
  module Menus
    include UI::MenuItems
    include UI::Actions

    class << self
      def main_menu
        Menu.new(
          '============ Железная дорога ==============',
          menu_items_for_stations +
          menu_items_for_routes +
          menu_items_for_trains +
          menu_item_exit
        )
      end

      def menu_items_for_stations
        {
          '1' => menu_item_create_station,
          '2' => menu_item_show_stations,
          '3' => menu_item_create_route
        }
      end

      def menu_items_for_routes
        {
          '4' => menu_item_show_routes,
          '5' => menu_item_edit_route

        }
      end

      def menu_items_for_trains
        {
          '6' => menu_item_create_train,
          '7' => menu_item_show_trains,
          '8' => menu_item_edit_trains,
          '9' => menu_item_move_train
        }
      end

      def menu_item_exit
        { '0' => ['Выход.'] }
      end

      def edit_trains_menu(train)
        Menu.new(
          'edit_trains',
          '1' => menu_item_add_wagon_to_train,
          '2' => menu_item_remove_wagon_from_train,
          '3' => menu_item_assign_route_to_train,
          '4' => menu_item_load_unload_wagon(train),
          '0' => menu_item_back
        )
      end

      def manage_weight_menu
        Menu.new(
          'Погрузка/выгрузка груза',
          '1' => menu_item_load_in_wagon,
          '2' => menu_item_unload_from_wagon,
          '0' => menu_item_back
        )
      end

      def manage_passenger_menu
        Menu.new(
          'pickup_passenger',
          '1' => menu_item_passenger_in,
          '2' => menu_item_passenger_out,
          '0' => ['Возврат в предыдущее меню.']
        )
      end

      def move_train_menu
        Menu.new(
          'move_trains',
          '1' => menu_item_move_train_forward,
          '2' => menu_item_move_train_backward
        )
      end

      def edit_route_menu
        Menu.new(
          'Изменить маршрут',
          '1' => menu_item_add_station_to_route,
          '2' => menu_item_remove_station_from_route
        )
      end
    end
  end
end
