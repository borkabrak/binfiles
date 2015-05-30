#!/usr/bin/env python
#
#   Find the largest prime factor of 600851475143
#       Version 2: Translate the algorithm from the version I have in ruby
#       (Because ruby ran it *so* much faster.  Test similar algorithms.
#
#       Result:  Yeah, it's fast, but it's BROKEN.  It doesn't work for, say,
#       '26' (gpf is '13', script report '2')

import math

number = 600851475143

gpf = 1

n = 0
while n <= math.sqrt(number):
    n = n + 1

    if (number % n == 0):
        factor = n
        # We found a factor.  Is it prime?
        prime = True
        
        for i in range(2, int(math.sqrt(n))):

            if (factor % i == 0):
                prime = False

        if prime:
            print factor
            gpf = factor

print "GPF:", gpf
