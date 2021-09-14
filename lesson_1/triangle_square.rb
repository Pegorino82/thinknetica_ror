=begin
Площадь треугольника можно вычислить, зная его основание (a) и высоту (h) по формуле: 1/2*a*h. 
Программа должна запрашивать основание и высоту треугольника и возвращать его площадь.
=end

print "Type the base: "
base = gets.chomp.to_f

print "Type the base height: "
height = gets.chomp.to_f

triangle_square = 0.5 * base * height

puts "Square is #{triangle_square}"