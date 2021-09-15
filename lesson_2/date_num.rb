=begin
  Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя). 
  Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным. 
  (Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?) 
  Алгоритм опредления високосного года: www.adm.yar.ru
=end

def is_leap(year)
  return year % 4 == 0 && year % 100 != 0 || year % 400 == 0    
end

def get_date_num(day, month, year)
  days_per_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  days_per_month[1] = 29 if is_leap(year)
  return days_per_month.slice!(0, month - 1).sum + day
end

print "Type day: "
day = gets.chomp.to_i

print "Type month: "
month = gets.chomp.to_i

print "Type year: "
year = gets.chomp.to_i

puts get_date_num(day, month, year)