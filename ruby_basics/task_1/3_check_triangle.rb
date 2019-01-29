# Check triangle

puts "Type lengths or 1st, 2nd and 3rd sides of triangle comma separated, for example: 3,4,5"
sides = gets.chomp.split(',').map(&:chomp).map(&:to_f)

if sides.size != 3 or sides.include?(0)
  puts "Start again please and input three (not 0) numbers"
  exit
end

res = []
if sides.uniq.size == 1 # all sides equal
  res << "2 sides are equal"
  res << "All 3 sides are equal"
  res << "Not the Square Triangle"
end
res << "2 sides are equal" if sides.uniq.size == 2

if sides.uniq.size == 3
  res << "All 3 sides are different"
end

max_side = sides.max
side_1, side_2 = sides.min(2)
res << "!!! This is the Square Triangle !!!" if max_side**2 == side_1**2 + side_2**2

puts res.join(', ')
