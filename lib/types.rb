module Types
  PASSENGER = :passenger
  CARGO = :cargo
  ALL = self.constants.map{|c| self.const_get(c)}
end
