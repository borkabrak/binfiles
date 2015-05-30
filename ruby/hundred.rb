#!/usr/bin/env ruby
#
# Playing around with this game found at: 
#   http://mindyourdecisions.com/blog/2013/06/17/monday-puzzle-how-a-startup-is-like-rolling-a-100-sided-die/
#
#   You roll a 100-sided die. You then have two choices: (1) you can cash out
#   and get paid the dollar amount of the roll, or (2) you can pay $1 to roll
#   the die again.
#   
#   You get the same two choices on every roll, and there is no limit to the
#   number of rolls you can make.
#   

rolls = []
roll = 0
score = 1
while( roll < 50 ) do
    score -= 1
    roll = rand(100) + 1
    rolls.push(roll) 
end
score += roll

puts rolls
puts "#{rolls.find_all { |e| e == 100 }.length} hundreds"
puts "Score: #{score}"
