require_relative 'game'

def main
  puts '----- Black Jack -----'
  opts = init
  loop do
    game(opts)
    print 'Please choose: 1 - To repeat game, 2 - To exit. : '
    command = gets.strip
    puts 'Thanks for the game! Bye!' if command == '2'
    break if command == '2'
  end
end

main
