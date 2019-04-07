class Player
  attr_accessor :bank, :hand
  attr_reader :name

  def initialize(_name = nil)
    @bank = 100
    @hand = []
  end

  def take(qty, cards)
    @hand += [cards[rand(cards.size)]]
    @hand += [cards[rand(cards.size)]] if qty != 1
    @hand
  end

  def show(opts = { front: true })
    puts "#{name}'s hand: #{hand_info(opts)}, #{sum_info(opts)}, Bank: #{@bank}"
  end

  def hand_info(opts)
    return '* ' * @hand.size unless opts[:front]

    @hand.map do |card|
      card[0].split('-').first + Deck.const_get(card[0].split('-').last)
    end.join(' ')
  end

  def sum_info(opts)
    return '*' unless opts[:front]

    "Sum: #{Deck.calc(@hand)}"
  end
end
