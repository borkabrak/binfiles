-- Let's Play Haskell!
-- To load, use `ghci <file>` or `:l <file>' from within ghci

-- Notes:
-- Haskell appears to work by declaring what something IS, not how it works.
-- May be related to the difference between functional and procedural
-- programming.
--
-- Lists in Haskell are *homegeneous*.  All elements must have the same type.

double x = x + x

half x = x / 2

hypotenuse x y = sqrt (x*x + y*y)

oddp x = if x `mod` 2 /= 0  -- funny-looking 'not equal' sign..
          then True
          else False

evenp x = not (oddp x)

lcat x y = x ++ y

prepend x y = x:y

-- Hello World
hello = putStrLn "Hello, World"

-- Good 'ol factorial
-- (The Wikipedia page gives six different ways of writing this)
fact n = if n < 2 then 1 else n * fact (pred n)


-- list comprehensions
----------------------

-- gimme x squared from the list 1..10
ten_squares = [ x*x | x <- [1..10]]

-- x squared out of 1 to 10, where x is even
ten_even_squares = [ x*x | x <- [1..10], x `mod` 2 == 0]

-- x squared out of 1 to 10, where x is even and where x squared is greater than x
ten_even_bigger_squares = [ x*x | x <- [1..10], x `mod` 2 == 0, x*x > x]

-- Fizz
fizz = [ if x `mod` 5 == 0 then "fizz" else "buzz" | x <- [1..10]]



