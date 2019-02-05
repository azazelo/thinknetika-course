require_relative 'route'
require_relative 'station'
require_relative 'train'

puts "-----------------------------------"
puts "IRON RAILWAY"
puts "Create stations"
station_a = Station.new("A")
puts "Created #{station_a.info}"
station_b = Station.new("B")
puts "Created #{station_b.info}"
station_z = Station.new("Z")
puts "Created #{station_z.info}"

puts "Create route"
route_1 = Route.new(station_a, station_z)
puts route_1.inspect

puts "Create trains"
train_1 = Train.new('001', "Passenger", 10)
puts train_1.info
train_2 = Train.new('002', "Cargo", 50)
puts train_2.info

puts "Station #{station_a.info} receives a #{train_1.info}"
station_a.receive_train(train_1)
puts "#{station_a.inspect}"
puts station_a.display_trains([train_1])


puts "#{train_1.info} receive route"
train_1.accept(route_1)
puts train_1.info
train_1.go_forward
puts "Increase speed by 10"
train_1.increase_speed(10)
puts "Go forward"
train_1.go_forward
puts train_1.info

puts train_1.current_station
puts train_1.go_forward
puts train_1.go_backward
puts train_1.go_backward
puts train_1.go_backward
