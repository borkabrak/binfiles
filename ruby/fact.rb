def fact1(n)
  return 1 if n < 1 
  n * fact1(n - 1)
end

def fact2(n)
  case n
  when 1
    1
  else
    n * fact2(n - 1)
  end
end

# Anonymous recursion?
def bork
   
end
puts bork()
