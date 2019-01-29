# Quadratic equation
# a * x * x + b * x + c = 0

puts "Type a,b,c coefficients"
a, b, c = gets.chomp.split(',').map(&:chomp).map(&:to_f)

d = b**2 - 4 * a * c

case true
when d > 0
  sqrt_of_d = Math.sqrt(d)
  x1 = (-b + sqrt_of_d) / (2 * a)
  x2 = (-b - sqrt_of_d / (2 * a)
  puts "Discriminant: #{d}"
  puts "x1 = #{x1}"
  puts "x2 = #{x2}"
when d == 0
  x1 = x2 = -b / (2 * a)
  puts "Discriminant: #{d}"
  puts "x1 = x2 = #{x1}"
when d < 0
  puts "There is no roots!"
end
