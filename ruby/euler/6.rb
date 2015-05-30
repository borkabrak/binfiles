#!/usr/bin/env ruby
# Find the difference between the sum of the squares of the first one hundred
# natural numbers and the square of the sum.

sum_of_squares = 0
sum = 0
(1..100).each { |n|
    sum_of_squares += n*n
    sum += n
}
square_of_sums = sum * sum

puts "#{square_of_sums} - #{sum_of_squares} = #{square_of_sums - sum_of_squares}"
