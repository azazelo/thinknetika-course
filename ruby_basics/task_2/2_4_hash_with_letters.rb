# 2.4. Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

vowels = %W()

vowels = %W(a e i o u y)
all = ("a".."z").to_a
h = {}
all.each do |letter|
  h[letter] = (all.index(letter) + 1) if vowels.include?(letter)
end

puts h
