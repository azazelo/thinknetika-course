require_relative 'players/human'
require_relative 'players/diller'
require_relative 'deck'

def main
  cards = Deck.cards.to_a
  diller = Diller.new
  human = Human.new(take_name)
  bank = 20
  human.bank -= 10
  diller.bank -= 10
  round_number = 0
  while 1 do
    round_number += 1
    puts '------------'
    puts "Game round: #{round_number}"
    if round_number == 1
      cards -= human.take(2, cards)
      cards -= diller.take(2, cards)
    end
    human .show_hand
    diller.show_hand(front: false)
    menu
    case gets.strip
    when '1' 
      diller_turn(diller, cards)
    when '2' 
      cards -= human.take(1, cards)
      diller_turn(diller, cards)
    when '3' 
      open_cards(diller, human)
      return
    end
    if human.hand.size + diller.hand.size == 6
      open_cards(diller, human) 
      return
    end
    puts 'Left cards: ' + cards.size.to_s
  end
end

def diller_turn(diller, cards)
  cards -= diller.take(1, cards) if Deck.score(diller.hand) < 17
end

def menu
  puts '1 - Пасс.'
  puts '2 - Взять карту.'
  puts '3 - Открываемся.'
  print ': '
end

def open_cards(diller, human)
  human.show_hand
  diller.show_hand
  puts 'Winner is ' + winner(human, diller)
end

def winner(human, diller)
  human_sum = Deck.score(human.hand)
  diller_sum = Deck.score(diller.hand)
  return 'Nobody' if human_sum >  21 && diller_sum >  21
  return 'Diller' if human_sum >  21 && diller_sum <= 21
  return 'Human'  if human_sum <= 21 && diller_sum >  21
  if human_sum <= 21 && diller_sum <= 21
    return 'Human'  if human_sum >  diller_sum
    return 'Nobody' if human_sum == diller_sum
    return 'Diller' if human_sum <  diller_sum
  end
end

def take_name
  print 'Представьтесь пожалуйста: '
  gets.strip
end

main