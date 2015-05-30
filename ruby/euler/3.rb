#!/usr/bin/env ruby
#
# Find the largest prime factor of 600851475143

number = 600851475143

class Fixnum

  def prime?
    # straightforward approach - test all numbers from 2 to sqrt(n)
    (2..(Math.sqrt self).floor).each do |n|
      return false if self % n == 0
    end
    return true
  end

  def factors
    (1..self).select { |n| ( self % n == 0) }
  end

end
puts "Calculating.."
# Nice try here, but this takes way too long.  Let's do it by hand..
# puts number.factors.reverse.find{|n| n.prime?}

number.downto(1).each do |n|
  if (number % n == 0)
    puts "Checking #{n} for primality.."
    if (n.prime?)
      puts "Found it:#{n}"
      break
    end
  end
end

puts "Done"

