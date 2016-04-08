#!/usr/bin/env ruby
#
#   Convert seconds to larger time units.  Or vice versa.
#
#   Reference is made in the comments to a Time Specification, or 'timespec'.
#   A timespec is a string describing a duration in terms of various
#   well-defined units of time.  It takes the form:
#
#       '<value><unit>[...]'
#
#   
#       value - a number specifying the unit count
#
#       unit - a letter specifying the unit
#
#       Example:
#
#           "1d9h3m45s" - one day, nine hours, three minutes and forty-five seconds
#
#
#       The full list of units and their corresponding value in seconds is
#       defined below.
#

class Duration

    attr_accessor :seconds

    # Define units of time in seconds
    @@units = {
        "s" => 1,                   # second
        "m" => 60,                  # minute
        "h" => 60 * 60,             # hour
        "d" => 60 * 60 * 24,        # day
        "w" => 60 * 60 * 24 * 7,    # week
    }

    def initialize(timespec)
        @seconds = to_seconds timespec
    end

    def to_s
        @seconds.to_s
    end

    def parsespec(timespec)
        timespec.scan(/\d+[#{@@units.keys.join("")}]/)
    end

    def to_seconds(timespec)
        # Return the given timespec in seconds

        # Parse each token (value/unit pair), multiplying the value by the
        # factor associated with the unit then adding the results
        parsespec(timespec).map do |term|
            value, unit = term.match(/(\d*)([\w])/)[1,2]
            value.to_i * @@units[unit]
        end.inject { |x,y| x+y }

    end

    def timespec(seconds=@seconds)
        # Return self as a time specification

        if seconds > 0 then
            # Get the first unit pair not greater than total seconds
            unitpair = @@units.sort {|x,y| x[1] <=> y[1] }.reverse.find { |p| p[1] <= seconds }
            # Return <number of units><unit designator><recurse on the remainder>
            "#{seconds / unitpair[1]}#{unitpair[0]}#{timespec(seconds % unitpair[1])}" 
        else
            # termination case
            ""
        end

    end

end
