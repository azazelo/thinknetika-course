class Player
  attr_accessor :bank, :hand
  attr_reader :name

  def initialize(_name = nil)
    @bank = 100
    @hand = []
  end

  def take(qty, cards)
    @hand += [cards[rand(cards.size)]]
    cards -= @hand
    @hand += [cards[rand(cards.size)]] if qty != 1
    @hand
  end

  def info(opts = { front: 'yes' })
    "#{name}'s hand: #{hand_info(opts)}, #{sum_info(opts)}, Bank: #{@bank}"
  end

  def hand_info(opts)
    return '* ' * @hand.size unless opts[:front] == 'yes'

    @hand.map do |card|
      card.rank + card.suit_view
    end.join(' ')
  end

  def sum_info(opts)
    return '*' unless opts[:front] == 'yes'

    "Sum: #{Deck.calc(@hand)}"
  end
end
