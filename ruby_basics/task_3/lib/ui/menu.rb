class Menu
  attr_reader :name, :items
  def initialize(name, items = {})
    @name = name
    @items = items
  end

  def show(opts = {})
    system('clear') if opts[:clear_screen]
    puts name
    items.each { |number, item| puts "#{number} - #{item.first}" }
    print ': '
    self
  end

  def command
    gets.strip
  end

  def handle_command(command, *options)
    res = items[command].last.call(*options)
    puts res if res.is_a?(String)
    return false if res.is_a?(String)

    res
  rescue RuntimeError => e
    puts "Упс! #{e.inspect}. Повторите ввод."
  end
end
