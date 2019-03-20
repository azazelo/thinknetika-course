require_relative 'instance_counter'
require_relative 'maker'
require_relative 'messages'
require_relative 'types'
require_relative 'validation'
require_relative 'accessors'

class Base
  include InstanceCounter
  include Maker
  include Types
  include Messages
  include Validation
  include Accessors
end
