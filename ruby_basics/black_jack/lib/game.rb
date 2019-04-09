require_relative 'players/human'
require_relative 'players/diller'
require_relative 'deck'

def game(opts)
  empty_hands(opts)
  (1..10).each do |round_number|
    IO.round_title(round_number)
    res = roll(round_number, opts)
    IO.left_cards_message(opts)
    break if res == 'return'
  end
  'return'
end

def empty_hands(opts)
  opts[:human] .hand = []
  opts[:diller].hand = []
end

def roll(round_number, opts)
  first_roll(round_number, opts) if round_number == 1
  opts[:human].bank -= 10
  opts[:diller].bank -= 10
  IO.show_hands(opts.merge(diller_face: 'no'))
  next_roll(round_number, IO.choose_option, opts)
end

def first_roll(round_number, opts)
  human_turn(round_number, opts)
  diller_turn(round_number, opts)
end

def next_roll(round_number, command, opts)
  human_turn(round_number, opts)  if command == '2'
  diller_turn(round_number, opts) if %w[1 2].include?(command)
  all_open(opts) if command == '3' ||
                    [opts[:human].hand.size, opts[:diller].hand.size] == [3, 3]
end

def human_turn(round_number, opts)
  qty = round_number == 1 ? 2 : 1
  opts[:cards] -= opts[:human].take(qty, opts[:cards])
end

def diller_turn(round_number, opts)
  if round_number == 1
    opts[:cards] -= opts[:diller].take(2, opts[:cards])
  elsif Deck.calc(opts[:diller].hand) < 17
    opts[:cards] -= opts[:diller].take(1, opts[:cards]) 
  end
end

def init
  {
    human:  Human.new(IO.take_name),
    diller: Diller.new,
    cards:  Deck.cards
  }
end

def all_open(opts)
  hero = winner(Deck.calc(opts[:human].hand), Deck.calc(opts[:diller].hand))
  calc_bank(hero, opts)
  IO.show_hands(opts)
  IO.show_hero(hero)
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
