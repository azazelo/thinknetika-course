module Types
  PASSENGER = :passenger
  CARGO = :cargo
  ALL = self.constants.map{|c| self.const_get(c)}

  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    def is_cargo?
      self.type == Types::CARGO
    end
    def is_passenger?
      self.type == Types::PASSENGER
    end
  end
end
