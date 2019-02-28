require_relative 'instance_counter'
class Menu
  include InstanceCounter
  attr_reader :items

  def initialize(name)
    @name = name
    @items = []
  end

  def show
    self.items.each(&:show)
    print ": "
    self
  end

  def create(rows)
    rows.each do |row|
      self.items << MenuItem.new(*row)
    end
    self
  end

  def handle_command(command, *options)
    item = self.items.detect { |instance| instance.number == command }
    item.block.call(*options)
    self
  end

end

class MenuItem
  include InstanceCounter
  attr_reader :text, :number, :block
  def initialize(number, text, block=nil)
    @number = number
    @text = text
    @block = block
    register_instance
  end

  def show
    puts "#{self.number} - #{self.text}"
  end
end
