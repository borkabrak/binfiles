#!/usr/bin/env ruby
#
# Let's see how efficient a primality test I can design without wholesale
# copy-pasting.  Reading up on concepts is cool, but no straight up ripping off
# an algorithm.

class Fixnum

  # Naive approach
  def prime?
    !(2..Math.sqrt(self)).find { |n| (self % n == 0) }
  end

  # A hopefully faster test
  def prime2?
    # Eliminate some simple cases
    return nil if self == 0 or self == 1 # Neither one nor zero are prime or composite
    small_primes = [2, 3, 5, 7, 11, 13]
    return true if small_primes.include?(self)

    # According to https://en.wikipedia.org/wiki/Primality_test,
    # All primes except 2 and 3 are of the form:
    #   6k ± 1
    # So we just need to test all k such that 6k + 1 < sqrt n
    return false if (self % 2 == 0)
    return false if (self % 3 == 0)
    max_k = (Math.sqrt(self).floor / 6) + 1
    (small_primes.max..max_k).each do |k|
      return false if (self % (6 * k - 1) == 0)
      return false if (self % (6 * k + 1) == 0)
    end
    return true
  end

end
test_cases = (0..10).to_a
test_cases.push( 21, 23, 90, 100001 )
test_cases.each do |n|
  print "#{n} is.."
  puts "#{n.prime? ? "" : "NOT "}prime.  prime2 says #{n.prime? == n.prime2? ? "MATCH" : "NO MATCH"}"
end
