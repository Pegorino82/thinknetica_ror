require_relative 'accessors'
require_relative 'station'
require_relative 'route'
require_relative 'train'


class Test
  include Accessors

  attr_accessor_with_history :a, :b
end

# test = Test.new
# puts test.instance_variables.inspect
#
# test.a = 5
# puts test.instance_variables.inspect
# test.a = 10
# test.a = 10
#
# test.b = 1
# test.b = 2
# puts test.instance_variables.inspect
# puts test.a_history.inspect
#
# Test.strong_attr_accessor('c', String)
# test.c = 'asd'
# puts test.instance_variables.inspect
# # puts Test.methods.inspect
# # puts test.methods.inspect
#
# puts test.c_history.inspect
#
# test.c = 'poi'
# puts test.c_history.inspect

begin
  puts Station.new(100)
rescue => e
    puts e
end
s1 = Station.new('asd')
s2 = Station.new('dsa')
puts s1
puts s2
begin
  r = Route.new('s1', 's2')
rescue => e
  puts e
  r = Route.new(s1, s2)
  puts r
end

begin
  puts Train.new('as')
rescue => e
  puts e
  puts Train.new('pas-01')
end


