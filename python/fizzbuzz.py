#!/usr/bin/env python
#
#   You know.. fizzbuzz.  Print numbers 1-100 but 'fizz' if mod 3, 'buzz' if mod 5, or 'fizzbuzz' if both

def fizznum(x):

        if x % 15 == 0:
            return "fizzbuzz"

        if x % 3 == 0:
            return "fizz"

        if x % 5 == 0:
            return "buzz"

        return x


for x in range(1,101):
    print fizznum(x)
