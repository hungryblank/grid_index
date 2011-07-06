require 'test/unit'
require 'grid_index'

class GridIndexTest < Test::Unit::TestCase

  class Element < Struct.new(:x, :y, :width, :height)
  end

  def test_dont_overlap
    element = Element.new(10, 5, 3, 2)
    other_element = Element.new(element.x + element.width,
                                element.y + element.height,
                                element.width,
                                element.height)
    index = GridIndex.new(20, 20)
    index = index.add(element)
    assert index.add(other_element).is_a?(GridIndex)
  end

  def test_overlap
    element = Element.new(1, 3, 1, 6)
    index = GridIndex.new(20, 20)
    index.add(element).is_a?(GridIndex)
    assert !index.add(element)
  end

  def test_delete
    element = Element.new(10, 5, 3, 2)
    index = GridIndex.new(20, 20)
    index = index.add(element)
    index = index.delete(element)
    assert index.add(element).is_a?(GridIndex)
  end

end
