#!/usr/bin/env python
#
#   What is the smallest positive number that is evenly divisible by all of the
#   numbers from 1 to 20?

n = 20
while True:
    n += 20
    gotit = True
    
    # divisibility by 11-19 implies all the lower factors
    for i in range(11, 20):
        if n % i != 0:
            gotit = False
   
    if gotit:
        print n
        break
