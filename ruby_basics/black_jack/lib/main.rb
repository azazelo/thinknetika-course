require_relative 'players/human'
require_relative 'players/computer'
require_relative 'deck'

def main
  cards_array = Deck.cards.to_a
  ai = Computer.new
  human = Human.new(take_name)
  # start
  round_number = 0
  while 1 do
    round_number += 1
    puts '------------'
    puts "Game round: #{round_number}"
    if round_number == 1
      cards_array -= human.take_card(2, cards_array)
      cards_array -= ai   .take_card(2, cards_array)
    end
    human.show_hand
    ai.show_hand(false)
    menu
    case gets.strip
    when '1' 
      cards_array -= ai   .take_card(1, cards_array)
      next
    when '2' 
      cards_array -= human.take_card(1, cards_array)
      cards_array -= ai   .take_card(1, cards_array)
    when '3' 
      open_cards(ai, human)
      return
    end
    puts 'Left cards: ' + cards_array.size.to_s
  end
end

def menu
  puts '1 - Пасс'
  puts '2 - Взять еще'
  puts '3 - Открываемся'
end

def open_cards(ai, human)
  human.show_hand
  ai.show_hand
  puts 'Winner is ' + winner(human, ai)
end

def winner(human, ai)
  human_sum = Deck.score(human.hand)
  ai_sum = Deck.score(ai.hand)
  return 'Nobody'   if human_sum >  21 && ai_sum >  21
  return 'Computer' if human_sum >  21 && ai_sum <= 21
  return 'Human'    if human_sum <= 21 && ai_sum >  21
  if human_sum <= 21 && ai_sum <= 21
    return 'Human'    if human_sum >  ai_sum
    return 'Nobody'   if human_sum == ai_sum
    return 'Computer' if human_sum <  ai_sum
  end
end

def take_name
  print 'Представьтесь пожалуйста: '
  gets.strip
end

main