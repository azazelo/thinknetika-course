class Player
  attr_accessor :bank, :hand
  attr_reader :name

  def initialize(name = nil)
    @bank = 100
    @hand = []
  end
  
  def take(qty, cards)
    @hand += roll(qty, cards)
  end
  
  def show_hand(opts = { front: true })
    if opts[:front]
      display_hand ||= @hand.map do |card| 
        card[0].split('-').first + Deck.const_get(card[0].split('-').last)
      end.join(' ')
      display_score = Deck.score(@hand)
    else
      display_hand ||= "* " * @hand.size
      display_score = "*"
    end
    puts "#{self.name}'s hand: #{display_hand}, Sum: #{display_score}" 
  end
  
  def roll(qty, cards)
    return [cards[rand(cards.size)]] if qty == 1
    [cards[rand(cards.size)], cards[rand(cards.size)]]
  end
end