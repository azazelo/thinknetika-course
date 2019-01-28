# Quadratic equation
# a * x * x + b * x + c = 0

puts "Type a,b,c coefficients"
a,b,c = gets.chomp.split(',').map(&:chomp).map(&:to_f)

d = b * b - 4 * a * c

case true
when d > 0
  x1 = (-b + Math.sqrt(d)) / (2 * a)
  x2 = (-b - Math.sqrt(d)) / (2 * a)
  puts "Discriminant: #{d.to_s}"
  puts "x1 = #{x1.to_s}"
  puts "x2 = #{x2.to_s}"
when d == 0
  x1 = x2 = -b / (2 * a)
  puts "Discriminant: #{d.to_s}"
  puts "x1 = x2 = #{x1.to_s}"
when d < 0
  puts "There is no roots!"
end
