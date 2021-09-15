=begin
  Заполнить массив числами фибоначчи до 100
=end

fib_max = 100
fib_arr = [0, 1]

fib_max.times do
    fib_arr.push(fib_arr[-1] + fib_arr[-2])
end

print fib_arr