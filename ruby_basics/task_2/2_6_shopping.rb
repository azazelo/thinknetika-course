# 6. Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара
# (может быть нецелым числом).
# Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп"
# в качестве названия товара. На основе введенных данных требуетеся:
# Заполнить и вывести на экран хеш, ключами которого являются названия товаров,
# а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара.
# Также вывести итоговую сумму за каждый товар.
# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".


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
