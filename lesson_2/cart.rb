=begin
  Сумма покупок. Пользователь вводит поочередно название товара, 
  цену за единицу и кол-во купленного товара (может быть нецелым числом). 
  Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" 
  в качестве названия товара. На основе введенных данных требуетеся:
  Заполнить и вывести на экран хеш, ключами которого являются названия товаров,
  а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара. 
  Также вывести итоговую сумму за каждый товар.
  Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".
=end

stop = 'stop'
$cart = {}

def add_good(name, price, amount)
  if !$cart.include?(name)
    $cart[name] = {'price' => price, 'amount' => amount}
  else
    $cart[name]['amount'] += amount      
  end
end

def get_total_cart_price(cart)
  total = 0
  $cart.each_value do | good |
    total += good['price'] * good['amount']
  end
  return total.floor(2)
end


loop do
  print "Type name: "
  name = gets.chomp
  if name == stop
    puts $cart
    puts get_total_cart_price($cart)
    break
  end

  print "Type price: "
  price = gets.chomp.to_f.floor(2)

  print "Type amount: "
  amount = gets.chomp.to_f.floor(2)

  add_good(name, price, amount)
end