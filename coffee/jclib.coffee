#!/usr/bin/env coffee

String::reverse = ->
    if @length < 2 then @ else @[@length - 1] + @[0...-1].reverse()

String::is_palindrome = ->
    return true if @length < 2
    if @[@length - 1] != @[0] then false else @[1...-1].is_palindrome() # 3 dots excludes the end

String::is_palindrome2 = ->
    return @toString() == @reverse()

String::pad = (len = 0, character = "0") ->
    character = character.toString()
    if @length > len
        @
    else
        (@ + character).pad(len, character)


# I like this part.  These list comprehensions are kickity:
console.log s for s in [

    # Tests to run
    "'#{data}'.."
    "pad(0,'0'):'#{ data.pad(0, '0') }'"
    "pad(10,0):'#{ data.pad(0, 0) }'"
    "pad(10,' '):'#{ data.pad(10,' ') }'"
    "pad(10,'0'):'#{ data.pad(10, '0') }'"

] for data in [

    # Data to test
    "laser"
    "radar"
    "racecar"
    "Coffeescript is.. actually pretty badass"
]

# Here's a neat way to define the factorial function..
fact = (n)-> [1..n].reduce (x,y)->x*y
