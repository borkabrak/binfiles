#!/usr/bin/env ruby
# Find the largest prime factor of 600851475143
#
# Edit:  This is BROKEN.  Check '26'
# cf. The solution I did in Python (not that Python is better -- it's a
# different algorithm)

x = 600851475143
lpf = 1

(2..Math.sqrt(x)).each { |n|
    if (x % n == 0) then
        factor = n
        
        # We found a factor.. is it prime?
        prime = true
        (2..Math.sqrt(factor)).each { |m|
            if (factor % m == 0) then
                prime = false
            end
        }
        if (prime) then
            puts factor 
            lpf = factor
        end
    end
}
puts lpf
