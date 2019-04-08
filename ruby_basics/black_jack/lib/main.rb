require_relative 'game'
require_relative 'io'

def main
  IO.init_title
  opts = init
  loop do
    game(opts)
    command = IO.repeat_or_exit_handle
    break if command == '2'
  end
end

main
