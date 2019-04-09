class IO
  
  GAME_MENU = {
    '1' => 'Пас.',
    '2' => 'Взять карту.',
    '3' => 'Открываемся.'
  }
  
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
    farewell if command == '2'
    command
  end
  
  def self.farewell
    puts 'Thanks for the game! Bye!'
  end

  def self.left_cards_message(opts)
    puts 'Left cards: ' + opts[:cards].size.to_s
  end

  def self.choose_option
    GAME_MENU.each{ |command, name| puts "#{command} - #{name}" }
    print ': '
    gets.strip
  end

  def self.show_hero(hero)
    puts "#{hero} won!".send(color(hero))
  end
  
  def self.color(hero)
    return 'green' if hero == 'Human'
    return 'red'   if hero == 'Diller'
    return 'blue'  if hero == 'Nobody'
  end

  def self.take_name
    print 'Представьтесь пожалуйста: '
    gets.strip
  end
end
