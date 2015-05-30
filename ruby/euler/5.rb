#!/usr/bin/env ruby
#   Find the lowest number that has 1..20 as factors
#
#   (Some optimization is done, but the algorithm still needs to be quicker.
#   3+ minutes? Geez..)

n = 0

# Check every multiple of the greatest required factor..
while (n += 20) do

    this_one = true
    # Every factor below 11 is implied by the rest (12 implies 2, 3, 4, and 6,
    # for example)
    (11..19).each { |factor|
        this_one = false if (n % factor != 0)
    }
    break if this_one
end

puts n
