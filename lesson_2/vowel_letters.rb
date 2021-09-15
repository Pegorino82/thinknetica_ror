=begin
  Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
=end

vowels = ["a", "e", "i", "o", "u", "y"]

letters = {}

("a".."z").each_with_index do |letter, pos|
    letters[letter] = pos + 1 if vowels.include?(letter)
end

puts letters