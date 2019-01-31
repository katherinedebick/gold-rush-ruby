require_relative 'Node'

# This is the graph class
class Graph
  def initialize(seed)
    @numnodes = 0
    @currentnode = nil
    @nodes = {}
    @seed = seed
    @random_node_generator = Random.new(seed)
  end
  
  def get_current_node
    @currentnode
  end
  
  def next_location
    next_int = @random_node_generator.rand(get_current_node.neighbors.length)
    @currentnode = @nodes[@currentnode.neighbors[next_int].location]
    @currentnode
  end

  def num_nodes
    return @numnodes
  end
  
  def add_location(n)
    if @numnodes == 0
      @currentnode = n
    end
    @nodes[n.location] = n
    @numnodes+=1
  end
  
  def get_node(locationkey)
    @nodes[locationkey]
  end
  
  def add_edge(location1, location2)
    temp1 = get_node(location1)
    temp2 = get_node(location2)
    temp1.add_neighbor(temp2)
    temp2.add_neighbor(temp1)
  end
end
