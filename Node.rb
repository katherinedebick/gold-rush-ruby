# This is the Node Class
class Node
  attr_accessor :max_gold
  attr_accessor :max_silver
  attr_accessor :location
  attr_accessor :neighbors

  def initialize(location, max_gold, max_silver, seed)
    @seed = seed
    @location = location
    @max_silver = max_silver
    @max_gold = max_gold
    @neighbors = []
  end

  def add_neighbor(adjacent_node)
    @neighbors << adjacent_node
  end
end
