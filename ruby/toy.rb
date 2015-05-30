#!/usr/bin/env ruby
#
#  Two ways of doing defaults?  This started as the diff between @thing and
#  self.thing (the latter references the method (supplied by attr_accessor, et.
#  al., while the former refs the property itself)
class Person
  attr_accessor :name, :age
  def initialize(n)
    @age = 30
  end

  def name
    "Method"
  end
end

p = Person.new name: "Fred"

puts "name:#{p.name} age:#{p.age}"
