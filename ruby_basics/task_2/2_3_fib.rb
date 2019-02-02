# 2.3. make array with fifonacci digits up to 100

fibs = [0,1,1]

loop do
  next_fib = fibs[-2] + fibs.last
  break if next_fib > 100
  fibs << next_fib
end

puts fibs
