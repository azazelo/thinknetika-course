require 'types'
require 'route'
require 'station'
require 'passenger_train'
require 'cargo_train'
require 'passenger_wagon'
require 'cargo_wagon'
require 'messages'
require 'monkey_patching'

RSpec.configure do |config|
  config.include Messages
end
