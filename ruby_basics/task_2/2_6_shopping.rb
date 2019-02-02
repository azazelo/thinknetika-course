# 6. Shopping program

class Cart
  def initialize(amount=0)
    @basket = {}
    @total = 0
  end

  def add_product(name, price, qty)
    @basket[name] = {price => ((@basket[name][price] rescue 0) + qty)}
  end

  def display_cart
    puts "Cart:"
    puts "  In a glance: #{@basket}"
    @basket.each do |name, price_qty|
      price_qty_arr = price_qty.to_a.flatten
      product_amount = price_qty_arr[0] * price_qty_arr[1]
      puts "  Product: #{name}, amount: #{product_amount}"
      @total += product_amount
    end
    puts "Total amount in cart is: #{@total}."

  end
end

cart = Cart.new

loop do

  puts "----------------------------------------------------"
  puts "This is Shopping."
  puts "!!! To EXIT type 'stop' in place of product name !!!"
  print "Type name of Product: "
  name = gets.chomp

  if name == "stop"
    cart.display_cart
    break
  end

  print "Type price of Product: "
  price = gets.chomp.to_f

  print "Type qty of Product: "
  qty = gets.chomp.to_f

  cart.add_product(name, price, qty)
end
