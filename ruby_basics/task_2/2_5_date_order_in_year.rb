# 5. Date order in year

puts "Type Day, Month, Year like 11, 9, 1996"
day, month, year = gets.chomp.split(',').map(&:chomp).map(&:to_i)

is_year_leap = (false or ((year % 4 == 0 and year % 100 != 0) or year % 400 == 0))

qty_days = [31, (is_year_leap ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

# sum_days = [0,31,31+(28or29),... ]
sum_days = [0]
qty_days.each_with_index do |days, index|
  sum_days[index] = sum_days[index-1] + qty_days[index-1] if index != 0
end

order_number = sum_days[month-1] + day

puts "You have typed:"
puts "  day: #{day}"
puts "  month: #{month}"
puts "  year: #{year}"
puts " this year is #{is_year_leap ? "" : "NOT"}LEAP"
puts " this day is number #{order_number} in year"
