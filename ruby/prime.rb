#!/usr/bin/env ruby

class Fixnum
  def prime?
    return false if (self % 2 == 0 )
    return false if (self % 3 == 0)

    # According to https://en.wikipedia.org/wiki/Primality_test,
    # All primes except 2 and 3 are of the form:
    #   6k ± 1
    #
    # So we just need to test all k such that 6k + 1 < sqrt n
    max_k = Math.sqrt(self).floor / 6
    (1..max_k).each do |k|
      return false if (self % (6 * k - 1) == 0)
      return false if (self % (6 * k + 1) == 0)
    end
    return true
  end
end

"11,21,22,23 100".split(/[ ,]/).each do |n|
  n = n.to_i
  puts "Is #{n} prime?: #{n.prime?}"
end
