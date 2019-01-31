require 'simplecov'
SimpleCov.start

require_relative 'Node'
require 'minitest/autorun'

# Tests the Node Class
class NodeTest < Minitest::Test
  # Test that an edge is added between two places
  def test_add_edge
    n = Node.new('sutter_creek', 4, 5, 340)
    neighbor = Node.new('coloma', 4, 6, 340)
    n.add_neighbor(neighbor)
    assert_equal n.neighbors.length, 1
  end
end
