require_relative 'instance_counter'
class Menu
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

  def self.show
    system('clear')
    puts "============ Железная дорога =============="
    self.instances.each(&:show)
    print ": "
  end

  def self.create(rows)
    rows.each do |row|
      self.new(*row)
    end
  end

  def self.handle_command(command, *options)
    item = self.instances.detect { |instance| instance.number == command }
    item.block.call(options)
  end

end
