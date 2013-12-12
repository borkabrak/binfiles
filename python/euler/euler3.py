#!/usr/bin/env python
#
#   Project Euler, Problem 3: 
#   
#   What is the largest prime factor of the number 600851475143?
#
#   Approach:
#       for i from 1..sqrt(n):
#           if n % i == 0:
#               if isprime( n / i ):
#                   return i
#                   exit

import math
import sys

# Default
number = 600851475143

if len(sys.argv) > 1:
    number = int(sys.argv[1])

def gpf(n):

    i = 1
    while i <= n:
        i = i + 1
        if (n % i == 0):
            print i, "*", n / i, "=", n
            if isprime(n / i): 
                return (n / i)

def isprime(n):

    for i in range(2, int(math.sqrt(n) + 1)):
        if (n % i == 0):
            return False

    return True

print gpf(number)
