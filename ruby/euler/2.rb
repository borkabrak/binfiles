#!/usr/bin/env ruby
#
# Find the sum of all even Fibonacci numbers less than or equal to four million

prev = 1
current = 2
sum = 2

while current < 4000000 do
 
  x = prev + current
  prev = current
  current = x

  sum += (current.even? ? current : 0)
end

puts sum
