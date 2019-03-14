require_relative 'instance_counter'
require_relative 'maker'
require_relative 'messages'
require_relative 'types'
require_relative 'validations'

class Base
  include InstanceCounter
  include Maker
  include Types
  include Messages
  include Validations
end
