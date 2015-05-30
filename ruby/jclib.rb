#!env ruby
#
#   Bits I wrote
#
#   This is more about the fun of writing, not necessarily usefulness

class String
  def rev
    # Reverse a string
    return self if self.length < 2
    self[-1] + self[0..-2].rev
  end
  
  def palindrome?
    # Quicker to just compare self with self.reverse, but this is more fun
    return true if self.length < 1
    self[0].downcase == self[-1].downcase ? self[1..-2].palindrome? : false
  end

  def caesar(shiftnum)
    rotted = ""
    alphabet = ("a".."z").to_a
    self.split("").each do |c|
      rotted += alphabet.rotate(shiftnum)[alphabet.index(c.downcase)]
    end
    rotted
  end

  def rot13
    self.caesar(13)
  end

  def iphmotj
    # An obfuscational technique that tries to preserve pronouncability. A
    # vowel changes to the next vowel, likewise for consonants.
    # The name comes from that process applied to 'english'
    
    result = ""
    vowels = "aeiouy".split ""
    consonants = "bcdfghjklmnpqrstvwxz".split ""
    self.split("").each do |c|
      c = c.downcase
      if vowels.index(c)
        result += vowels[(vowels.index(c) + 1) % vowels.length]
      else
        result += consonants[(consonants.index(c) + 1) % consonants.length]
      end
    end
    result
  end

end


# Testing
test_cases = [
  "borkabrak",
  "radar",
  "Radar",
  "boob",
  "book",
  "a",
  "",
  "birdy",
]

test_cases.each do |s|
  puts "'#{s}' == '#{s.rev}': #{s.palindrome?.to_s.upcase}"
  puts "\trot13:'#{s.rot13}'"
  puts "\tiphmotj: '#{s.iphmotj}'"
end
