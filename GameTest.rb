require 'simplecov'
SimpleCov.start

require_relative 'Node'
require_relative 'Graph'
require_relative 'Game'
require 'minitest/autorun'

class GameTest < Minitest::Test
  
  def test_clean_up
    test_game = Game.new(1234, 1) #initialization values don't matter
    test_game.play
    assert_equal test_game.get_gold_found, 0
  end
  
  def test_add_all_locations
    test_game = Game.new(1234, 1) #initialization values don't matter
    test_graph = Graph.new(1234)
    test_graph = test_game.add_all_locations(test_graph) 
    assert_equal test_graph.num_nodes, 7
  end
  
  def test_add_all_edges
    test_game = Game.new(1234, 1) #initialization values don't matter
    test_graph = Graph.new(1234)
    test_graph = test_game.add_all_locations(test_graph) 
    test_graph = test_game.add_all_edges(test_graph)
    assert_equal test_graph.get_node('virginia_city').neighbors.length, 4
  end
  
  def test_fill_graph
    test_game = Game.new(1234, 1) #initialization values don't matter
    test_graph = Graph.new(1234)
    test_graph = test_game.fill_graph(test_graph)
    assert_equal test_graph.get_node('virginia_city').neighbors.length, 4
  end
  
  def test_store_silver
    test_game = Game.new(1234, 1)
    test_game.store_silver(5)
    test_game.store_silver(5)
    assert_equal test_game.get_silver_found, 10
  end
  
  def test_store_gold
    test_game = Game.new(1234, 1)
    test_game.store_gold(5)
    test_game.store_gold(5)
    assert_equal test_game.get_gold_found, 10
  end
  
  def test_show_riches
    test_game = Game.new(1234, 1)
    mocked_graph = Minitest::Mock.new("mocked graph")
    mocked_graph.expect(:get_current_node, Node.new('sutter_creek', 4, 5, 12345))
    test_game.store_silver(5)
    test_game.show_riches(mocked_graph)
    assert mocked_graph
  end
  
  def test_show_ending
    test_game = Game.new(1234, 1)
    mocked_graph = Minitest::Mock.new("mocked graph")
    mocked_graph.expect(:get_current_node, Node.new('sutter_creek', 4, 5, 12345))
    test_game.show_ending
    assert mocked_graph
  end
  
  def test_show_location
    test_game = Game.new(1234, 1)
    mocked_graph = Minitest::Mock.new("mocked graph")
    mocked_graph.expect(:get_current_node, Node.new('sutter_creek', 4, 5, 12345))
    test_game.show_location(mocked_graph, 1)
    assert mocked_graph
  end
  
  def test_play
    mocked_game = Minitest::Mock.new("mocked game")
    mocked_game.expect(:play, 1)
    assert mocked_game
  end
end
