# 2.4. make hash with vowels key - letter, value - number of letter in alfabet (a - 1)

vowels = %W()

vowels = %W(a e i o u y)
all = ("a".."z").to_a
h = {}
all.each do |letter|
  h[letter] = (all.index(letter) + 1) if vowels.include?(letter)
end

puts h
