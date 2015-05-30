# Cartesian point
class Point

  class PointError < StandardError
  end

  attr_accessor :x, :y

  def initialize(text)
      (@x, @y = text.scan(/[\d\.]+/).map { |x| x.to_i })
  end

  def to_s
    "#{@x}x#{@y}"
  end

  def distance_to(point)
    distance = Math.sqrt( (@x - point.x) ** 2 + (@y - point.y) ** 2)
    return distance.round 2
  end

end

