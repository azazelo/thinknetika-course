# Ideal weight

puts "Type your name"
name = gets.chomp
puts "Type your height"
height = gets.chomp

ideal_weight = height.to_i - 110

if ideal_weight < 0
  puts "Hello, #{name}, your have ideal weight!"
else
  puts "Hello, #{name}, your ideal weight is #{ideal_weight}."
end
