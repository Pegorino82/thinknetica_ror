=begin
  Идеальный вес. 
  Программа запрашивает у пользователя имя и рост 
  и выводит идеальный вес по формуле (<рост> - 110) * 1.15,
  после чего выводит результат пользователю на экран с обращением по имени.
  Если идеальный вес получается отрицательным, то выводится строка "Ваш вес уже оптимальный"   
=end

=begin
  Вопрос по условию задачи - получается что оптимальный вес - для всех людей с ростом меньше 110?
=end

print "Type your name: "
name = gets.chomp
name.capitalize!

print "Type your heigth: "
heigth = gets.chomp.to_f
  
weight = (heigth - 110) * 1.15

puts "#{name}, your weight #{weight}"
puts "#{name}, your weight is optimal!" if weight < 0 