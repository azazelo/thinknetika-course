# Check triangle

puts "Type lengths or 1st, 2nd and 3rd sides of triangle comma separated, for example: 3,4,5"
sides = gets.chomp.split(',').map(&:chomp).map(&:to_f)
side_1, side_2, side_3 = sides

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
if sides.uniq.size == 2
  res << "2 sides are equal"
end
if sides.uniq.size == 3
  res << "All 3 sides are different"
end

def square(num)
  num * num
end

max_side = sides.max
other_sides = sides - [max_side]
if other_sides.size == 2
  if max_side > other_sides.max
    if square(max_side) == square(other_sides[0]) + square(other_sides[1])
      res << "!!! This is the Square Triangle !!!"
    end
  end
end

puts res.join(', ')
