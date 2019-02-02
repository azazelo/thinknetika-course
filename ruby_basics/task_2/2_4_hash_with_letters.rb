# 2.4. make hash with vowels key - letter, value - number of letter in alfabet (a - 1)

vowels = %w[a e i o u y]
all = ("a".."z")
h = {}
all.each.with_index(1) do |letter, index|
  h[letter] = index if vowels.include?(letter)
end

puts h
