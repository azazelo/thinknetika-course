# 2.2. Make array with digits 10 to 100 with step 5

arr = (10..100).select{|i| i%5 == 0 }
puts arr
