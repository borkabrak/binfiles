#!/usr/bin/env ruby
# Find the sum of all even Fibonacci numbers up to 4 million

# current number
curr = 1

# previous number
prev = 0

# accumulator
sum = 0

while (curr < 4000000) do

    temp = curr
    curr = prev + curr
    prev = temp

    if (curr % 2 == 0) then
        sum += curr
    end
end

puts sum
