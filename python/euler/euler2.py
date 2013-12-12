#!/usr/bin/env python
#
#   Project Euler, Problem 2: 
#       Find the sum of all numbers in the fibonacci sequence whose values are: 
#       * even
#       * less than four million

tempcurr = 0
prev    = 1
current = 1
sum = 0

while current < 4000000:
    #print current

    if current % 2 == 0:
        sum += current

    tempcurr = current
    current = current + prev
    prev = tempcurr


print "Sum:", sum
