#!/usr/bin/env ruby
# Find the sum of all multiples of 3 or 5 below 1000

sum = 0

(1..999).each { |n|
    if (( n % 3 == 0 ) or ( n % 5 == 0)) then 
        sum = sum + n
    end
}
puts sum
