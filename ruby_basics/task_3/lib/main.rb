#!/usr/bin/ruby
require_relative 'route'
require_relative 'station'
require_relative 'types'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'ui/menus'

# - Manage stations
# - Manage trains
# - Manage routes

def management
  opts = { stations: [], routes: [], trains: [] }
  seed(opts)
  loop do
    (menu ||= UI::Menus.main_menu).show(clear_screen: true)
    command = gets.strip
    break if command == '0'

    menu.handle_command(command, opts)
    print '>> Нажмите любую клавишу для продолжения...'
    gets.strip
  end
end

def seed(opts = {})
  seed_stations(opts)
  seed_routes(opts)
  seed_trains(opts)
  seed_wagons(opts)
end

def seed_stations(opts = {})
  opts[:stations] << Station.new('Москва')
  opts[:stations] << Station.new('Волгоград')
  opts[:stations] << Station.new('Астрахань')
end

def seed_routes(opts = {})
  opts[:routes] << Route.new(
    '111',
    opts[:stations].first,
    opts[:stations].last
  )
end

def seed_trains(opts = {})
  opts[:trains] << PassengerTrain.new('001-99').accept(opts[:routes].first)
  opts[:trains] << CargoTrain.new('002-bb').accept(opts[:routes].first)
end

def seed_wagons(opts = {})
  opts[:trains].first.wagons << PassengerWagon.new('1', 1)
  opts[:trains].last.wagons << CargoWagon.new('1', 100)
end

management
