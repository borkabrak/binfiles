#!/usr/bin/env ruby
#
# Write a freakin' sort algorithm for a job test screening..


def mysort(arr)
  # The computational complexity of this algorithm is O(n^^2), and is similar
  # to selection sort.  This is not idiomatically ideal Ruby - I've tried to
  # mostly use language constructs common to many languages.

  sorted = []

  smallest_index = 0
  while (arr.length > 0) do
    for i in (0..(arr.length - 1))
      if arr[i] < arr[smallest_index]
        smallest_index = i
      end
    end
    sorted.push arr.delete_at(smallest_index) 
    smallest_index = 0
  end

  return sorted 

end

unsorted = [6,8,20,34,1,867,3,1,1,65,9,6,23,9,0]
puts "Known: #{unsorted.sort}"
puts "Original:#{unsorted}"
puts "Sorted: #{mysort(unsorted)}"
