#!/usr/bin/env ruby
# Find the largest palindrome that is the product of two three-digit numbers

def palindrome?(x)
    return true if x.length < 2
    return false if x[0] != x[x.length - 1]
    return palindrome? x[1..(x.length - 2)]
end

pals = []

(100..999).each { |i|
    (100..999).each { |j|
        n = i * j
        pals.push(n) if palindrome? n.to_s
    }
}

puts pals.max
