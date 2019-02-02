# 5. Date order in year

puts "Type Day, Month, Year like 11, 9, 1996"
day, month, year = gets.split(',').map(&:to_i)

is_year_leap = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0

qty_days = [31, (is_year_leap ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

sum_days = 0
qty_days.take(month - 1).each { |qty|  += qty }

puts "You have typed:"
puts "  day: #{day}"
puts "  month: #{month}"
puts "  year: #{year}"
puts " this year is #{"NOT" if is_year_leap}LEAP"
puts " this day is number #{sum_days + day} in year"
