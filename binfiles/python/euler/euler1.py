#!/usr/bin/env python
#
#   Project Euler, Problem 1: 
#       Find the sum of all multiples of 3 or 5 below 1000

sum = 0
for i in range(1000):
    if (i % 3 == 0) or (i % 5 == 0):
        sum += i

print sum
