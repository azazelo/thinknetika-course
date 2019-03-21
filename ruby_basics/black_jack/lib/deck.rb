class Deck
  attr_reader :cards, :suits
  def initialize
    
    #           червы  трефы бубны    пики
    @suits = %w[hearts clubs diamonds spades]
    @cards = []
    @suits.each do |suit|
      @cards += card_faces.map { |nominal| "#{nominal.to_s}-#{suit}" }.flatten
    end
  end
  
  def card_faces
    non_trumps + trumps
  end
  
  def non_trumps
    (2..10).to_a
  end

  def trumps
    %w[ace king queen jack]
  end
end
