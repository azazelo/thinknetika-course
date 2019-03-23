require_relative 'players/human'
require_relative 'deck'

def main
  cards_array = Deck.cards.to_a
  loop do
    prompt
    chosen_cards = roll(cards_array)
    cards_array -= chosen_cards
    puts chosen_cards
    puts cards_array.size
    menu
    action = gets.strip
    return
  end
end

def prompt
  print 'Представьтесь пожалуйста: '
  name = gets.strip
  Human.new(name)
end

def menu
  puts '1 - Пасс'
  puts '2 - Взять еще'
  puts '3 - Открываемся'
end

def roll(cards)
  [cards[rand(52)], cards[rand(52)]]
end

main