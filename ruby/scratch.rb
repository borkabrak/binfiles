#!/usr/bin/env ruby

require "./JClib.rb"

# Here is a function to run test cases.  Pass it an argument of test cases and
# code describing the test, and it will run the test on each case.
#
#  Y'know.. Ruby seems to have TMTOWTDI as bad as Perl, at least in the
#  language itself..
def runtest(data)

    data.each do |t|
        yield t
    end

end

# So if that is available from a module or class we've included, we can just do
# the following:

# Set the data
testdata = "radar Jonathan racecar x Okay".split

# Set the test
runtest testdata do |s|
    puts "'#{s}' is#{s.palindrome? ? "" : " NOT"} a palindrome"
end
       

# Okay, go!  
#runtest(testdata, &test)
