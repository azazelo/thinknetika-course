class IO
  def self.init_title
    puts '----- Black Jack -----'
  end

  def self.round_title(round_number)
    puts "----\nGame round: #{round_number}, Bank: 20."
  end

  def self.show_hands(opts)
    opts[:human_face]  ||= 'yes'
    opts[:diller_face] ||= 'yes'
    puts opts[:human] .info(front: opts[:human_face])
    puts opts[:diller].info(front: opts[:diller_face])
  end

  def self.repeat_or_exit_handle
    print 'Please choose: 1 - To repeat game, 2 - To exit. : '
    command = gets.strip
    puts 'Thanks for the game! Bye!' if command == '2'
    command
  end

  def self.left_cards_message(opts)
    puts 'Left cards: ' + opts[:cards].size.to_s
  end

  def self.choose_option
    puts '1 - Пас.'
    puts '2 - Взять карту.'
    puts '3 - Открываемся.'
    print ': '
    gets.strip
  end

  def self.show_hero(hero)
    puts "#{hero} won!"
  end

  def self.take_name
    print 'Представьтесь пожалуйста: '
    gets.strip
  end
end
