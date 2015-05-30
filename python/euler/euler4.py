#!/usr/bin/env python
#
# Find the largest palindrome made from the product of two 3-digit numbers.

def ispal(x):
    x = str(x)

    if len(x) < 2:
        return True

    if x[0] != x[len(x)-1]:
        return False

    return ispal(x[1:-1])

pals = []

for i in range(100, 999):
    for j in range(100, 999):
        n = i * j
        if ispal(n):
            pals.append(n)

print max(pals)
