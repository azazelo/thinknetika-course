# The area of a triangle

puts "Type triangle's base length"
base = gets.chomp.to_f
puts "Type triangle's height length"
height = gets.chomp.to_f

area = base * height / 2
puts "Area of triangle is #{area}."
