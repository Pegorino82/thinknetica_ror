=begin
  Программа запрашивает у пользователя 3 стороны треугольника и определяет,
  является ли треугольник прямоугольным (используя теорему Пифагора www-formula.ru),
  равнобедренным (т.е. у него равны любые 2 стороны) или равносторонним (все 3 стороны равны) 
  и выводит результат на экран. 
  Подсказка: чтобы воспользоваться теоремой Пифагора, 
  нужно сначала найти самую длинную сторону (гипотенуза) 
  и сравнить ее значение в квадрате с суммой квадратов двух остальных сторон. 
  Если все 3 стороны равны, то треугольник равнобедренный и равносторонний, но не прямоугольный.
=end

print "Type first side of triangle: "
side_one = gets.chomp.to_f

print "Type second side of triangle: "
side_two = gets.chomp.to_f

print "Type third side of triangle: "
side_three = gets.chomp.to_f

def is_right(a, b, c)
    side_one, side_two, hypotenuse = [a, b, c].sort
    return hypotenuse ** 2 == (side_one ** 2 + side_two ** 2)
end

def is_equilateral(a, b, c)
  return a == b && b == c
end

def is_isosceles(a, b, c)
  return a == b || a == c || b == c
end

def not_exists(a, b, c)
  return !(a + b > c && a + c > b && b + c > a) 
end


if not_exists(side_one, side_two, side_three)
  puts "not exists"
elsif is_equilateral(side_one, side_two, side_three)
  puts "not right, all sides are equals"
elsif is_right(side_one, side_two, side_three) && is_isosceles(side_one, side_two, side_three)
  puts "right triangle and two sides are equal" 
elsif is_right(side_one, side_two, side_three)
  puts "right triangle" 
elsif is_isosceles(side_one, side_two, side_three)
  puts "not right, two sides are equal"  
else
  puts "other case"
end  