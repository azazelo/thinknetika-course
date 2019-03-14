module Types
  PASSENGER = :passenger
  CARGO = :cargo
  ALL = constants.map { |c| const_get(c) }

  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    def cargo?
      type == Types::CARGO
    end

    def passenger?
      type == Types::PASSENGER
    end
  end
end
