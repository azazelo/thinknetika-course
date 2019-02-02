# 2.3. make array with fifonacci digits up to 100

fibs = [0, 1, 1]

while (next_fib = fibs[-2] + fibs.last) < 100 do
  fibs << next_fib
end

puts fibs
