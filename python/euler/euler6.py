#!/usr/bin/env python
#
#   Find the difference between the sum of the squares of the first one hundred
#   natural numbers and the square of the sum.

sum_of_squares = sum([x * x for x in range(1,101)])

square_of_sum = sum(range(1,101)) * sum(range(1,101))

print square_of_sum - sum_of_squares 
