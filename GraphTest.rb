require 'simplecov'
SimpleCov.start

require_relative 'Node'
require_relative 'Graph'
require 'minitest/autorun'

class GraphTest < Minitest::Test
  def setup
    @g = Graph.new(12345)
  end
  
  def test_add_location
    n = Node.new('sutter_creek', 4, 5, 12345)
    @g.add_location(n);
    assert_equal @g.num_nodes, 1
  end
  
  def test_add_edge
    n1 = Node.new('sutter_creek', 4, 5, 12345)
    n2 = Node.new('coloma', 4, 5, 12345)
    @g.add_location(n1)
    @g.add_location(n2)
    @g.add_edge('sutter_creek', 'coloma')
    assert_equal n1.neighbors.length, 1
  end
  
  def test_get_current_node
    n = Node.new('sutter_creek', 4, 5, 12345)
    @g.add_location(n)
    assert_equal @g.get_current_node.location, 'sutter_creek'
  end
  
  def test_next_location
    n1 = Node.new('sutter_creek', 4, 5, 12345)
    n2 = Node.new('coloma', 4, 5, 12345)
    @g.add_location(n1)
    @g.add_location(n2)
    @g.add_edge('sutter_creek', 'coloma')
    tempn = @g.next_location
    assert_equal tempn.location, 'coloma'
  end
end