#Commodity class to build an index for a grid and easily rule out overlapping
#elements uses only integers using their binary representation
#it represents the whole grid using n integers where n is the grid height

class GridIndex

  #given a length returns it's binary representation
  #  bin_1(3)
  #  => 7
  def self.bin_1(length)
    (1 << length) - 1
  end

  #initialize a surface with with and height
  def initialize(width, height)
    @width = width
    @height = height
    @rows = (1..height).map { 0 }
  end

  #returns the new index if the element doesn't overlap on
  #the current index element must provide the following interface
  #  element.x => position of element on x axis
  #  element.y => position of element on y axis
  #  element.width  => extension of element on x axis
  #  element.length => extension of element on y axis
  def add(element)
    bin_row = bin_row(element)
    element_rows(element).each { |y|
      return false if ((@rows[y] & bin_row) != 0)
    }.each { |y|
      @rows[y] = @rows[y] | bin_row
    }
    self
  end

  def bin_row(element)
    GridIndex.bin_1(element.width) << element.x
  end

  def element_rows(element)
    ((element.y)..(element.y + element.height - 1))
  end

  def delete(element)
    bin_row = bin_row(element)
    element_rows(element).each { |y| @rows[y] = @rows[y] ^ bin_row }
    self
  end

  def print
    puts (@rows.map { |row| row.to_s(2).rjust(@width, '0') })
  end

end
