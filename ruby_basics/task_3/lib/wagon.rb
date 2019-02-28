require_relative 'maker'
require_relative 'validations'
class Wagon
  include Validations
  include Maker
  include Messages::Wagon

  attr_reader :number, :type
  validates :number, presence: true
  validates :type,  presence: true, inclusion: Types::ALL
end
