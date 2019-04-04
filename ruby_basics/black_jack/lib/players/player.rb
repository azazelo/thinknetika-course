class Player
  attr_accessor :bank, :hand
  attr_reader :name

  def initialize(name = nil)
    @bank = 100
    @hand = []
  end
  
  def take_card(qty, cards_array)
    @bank -= 10
    @hand += take(qty, cards_array)
    cards_array -= @hand
    @hand
  end
  
  def show_hand(front = true)
    if front
      display_hand ||= @hand.map do |card| 
        Deck.const_get(card[0].split('-').last) + card[0].split('-').first
      end.join(' ')
      display_score = Deck.score(@hand)
    else
      display_hand ||= "* " * @hand.size
      display_score = "*"
    end
    puts "#{self.class.name} hand: #{display_hand}, Score: #{display_score}" 
  end
  
  def take(qty, cards)
    if qty == 1
      [cards[rand(cards.size)]]
    else
      [cards[rand(cards.size)], cards[rand(cards.size)]]
    end
  end


end