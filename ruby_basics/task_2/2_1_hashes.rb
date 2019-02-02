# 2.1. Craeat hash with months and qty days in months.
# in loop print months with days == 30

months = {
  January: 31,
  February: 28,
  March: 31,
  April: 30,
  May: 31,
  June: 30,
  July: 31,
  August: 31,
  September: 30,
  October: 31,
  November: 30,
  December: 31
}

months.each do |month, days|
  puts "#{month}: #{days}" if days == 30
end
