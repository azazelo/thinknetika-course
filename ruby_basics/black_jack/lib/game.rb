require_relative 'players/human'
require_relative 'players/diller'
require_relative 'deck'

def game(opts)
  empty_hands(opts)
  (1..10).each do |round_number|
    puts "----\nGame round: #{round_number}, Bank: 20."
    res = roll(round_number, opts)
    break if res == 'return'

    puts 'Left cards: ' + opts[:cards].size.to_s
  end
  'return'
end

def empty_hands(opts)
  opts[:human] .hand = []
  opts[:diller].hand = []
end

def roll(round_number, opts)
  first_roll(opts) if round_number == 1
  opts[:human].show
  opts[:diller].show(front: false)
  next_roll(choose_option, opts)
end

def first_roll(opts)
  opts[:cards] -= opts[:human] .take(2, opts[:cards])
  opts[:cards] -= opts[:diller].take(2, opts[:cards])
  opts[:human].bank -= 10
  opts[:diller].bank -= 10
end

def next_roll(command, opts)
  human_turn(opts)  if command == '2'
  diller_turn(opts) if %w[1 2].include?(command)
  all_open(opts) if command == '3' ||
                    [opts[:human].hand.size, opts[:diller].hand.size] == [3, 3]
end

def human_turn(opts)
  opts[:cards] -= opts[:human].take(1, opts[:cards])
end

def diller_turn(opts)
  opts[:cards] -= opts[:diller].take(1, opts[:cards]) if
    Deck.calc(opts[:diller].hand) < 17
end

def init
  {
    human:  Human.new(take_name),
    diller: Diller.new,
    cards:  Deck.cards.to_a
  }
end

def choose_option
  puts '1 - Пас.'
  puts '2 - Взять карту.'
  puts '3 - Открываемся.'
  print ': '
  gets.strip
end

def all_open(opts)
  hero = winner(Deck.calc(opts[:human].hand), Deck.calc(opts[:diller].hand))
  calc_bank(hero, opts)
  opts[:human] .show
  opts[:diller].show
  puts "#{hero} won!"
  'return'
end

def calc_bank(hero, opts)
  case hero
  when 'Human'
    opts[:human].bank += 20
  when 'Diller'
    opts[:diller].bank += 20
  when 'Nobody'
    opts[:human].bank  += 10
    opts[:diller].bank += 10
  end
end

def winner(h_sum, d_sum)
  return 'Nobody' if nobody_won(h_sum, d_sum)

  return 'Diller' if diller_won(h_sum, d_sum)

  'Human'
end

def nobody_won(h_sum, d_sum)
  (h_sum >  21 && d_sum >  21) || (h_sum <= 21 && d_sum <= 21 && h_sum == d_sum)
end

def diller_won(h_sum, d_sum)
  (h_sum >  21 && d_sum <= 21) || (h_sum <= 21 && d_sum <= 21 && h_sum < d_sum)
end

def human_won(h_sum, d_sum)
  (h_sum <= 21 && d_sum > 21) || (h_sum <= 21 && d_sum <= 21 && h_sum > d_sum)
end

def take_name
  print 'Представьтесь пожалуйста: '
  gets.strip
end
