#!/usr/bin/env python
#
#   What is the 10001st prime number?

import math

def prime_number(x):

    prime_count = 0
    i = 1

    while (True):
        if isprime(i):
            if prime_count < x:
                prime_count += 1 
            else: 
                return i
        i += 1

def isprime(x):
    for i in range(2, int(math.sqrt(x) + 1)):
        if x % i == 0:
            return False

    return True

print prime_number(10001)
