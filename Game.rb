require_relative 'Node'
require_relative 'Graph'

# Game controls and manipulates the graph of locations
class Game
  def initialize(seed, numprospectors)
    @numprospectors = numprospectors
    @current_prospector = 1
    @last_location = 'sutter_creek'
    @seed = seed
    @gold_found = 0
    @this_round_gold = 0
    @this_round_silver = 0
    @silver_found = 0
    @gold_generator = Random.new(seed)
    @numdays = 0
  end

  def clean_up
    @this_round_gold = 0
    @this_round_silver = 0
    @silver_found = 0
    @gold_found = 0
    @numdays = 0
  end

  def add_all_locations(graph)
    sutter_creek = Node.new('sutter_creek', 2, 0, @seed)
    coloma = Node.new('coloma', 3, 0, @seed)
    angels_camp = Node.new('angels_camp', 4, 0, @seed)
    nevada_city = Node.new('nevada_city', 5, 0, @seed)
    virginia_city = Node.new('virginia_city', 3, 3, @seed)
    midas = Node.new('midas', 0, 5, @seed)
    el_dorado_canyon = Node.new('el_dorado_canyon', 0, 10, @seed)
    graph.add_location(sutter_creek)
    graph.add_location(coloma)
    graph.add_location(angels_camp)
    graph.add_location(nevada_city)
    graph.add_location(virginia_city)
    graph.add_location(midas)
    graph.add_location(el_dorado_canyon)
    graph
  end

  def add_all_edges(graph)
    graph.add_edge('sutter_creek', 'coloma')
    graph.add_edge('sutter_creek', 'angels_camp')
    graph.add_edge('coloma', 'virginia_city')
    graph.add_edge('angels_camp', 'virginia_city')
    graph.add_edge('angels_camp', 'nevada_city')
    graph.add_edge('virginia_city', 'el_dorado_canyon')
    graph.add_edge('virginia_city', 'midas')
    graph.add_edge('midas', 'el_dorado_canyon')
    graph
  end

  def fill_graph(graph)
    graph = add_all_locations(graph)
    graph = add_all_edges(graph)
    graph
  end

  def store_gold(gold)
    @gold_found += gold
    @this_round_gold = gold
  end

  def mine_gold(graph)
    if graph.get_current_node.max_gold > 0
      new_gold = @gold_generator.rand(graph.get_current_node.max_gold + 1)
    else
      new_gold = 0
    end
    store_gold(new_gold)
    graph
  end

  def store_silver(silver)
    @silver_found += silver
    @this_round_silver = silver
  end

  def mine_silver(graph)
    if graph.get_current_node.max_silver > 0
      new_silver = @gold_generator.rand(graph.get_current_node.max_silver + 1)
    else
      new_silver = 0
    end
    store_silver(new_silver)
    graph
  end

  def rush(graph)
    visits = 0
    while visits < 5
      show_location(graph, visits)
      if visits < 4
        graph = mine_gold(graph)
        graph = mine_silver(graph)
        while @this_round_gold != 0 || @this_round_silver != 0
          graph = mine_gold(graph)
          graph = mine_silver(graph)
          show_riches(graph)
          @numdays += 1
        end
      else
        graph = mine_gold(graph)
        graph = mine_silver(graph)
        while @this_round_gold > 1 || @this_round_silver > 2
          graph = mine_gold(graph)
          graph = mine_silver(graph)
          show_riches(graph)
          @numdays += 1
        end
      end
      @last_location = graph.get_current_node.location
      graph.next_location
      visits += 1
    end
    show_ending
    clean_up
  end

  def show_riches(graph)
    if @this_round_gold.zero? && @this_round_silver == 1
      print "\t Found #{@this_round_silver} ounce of silver in #{graph.get_current_node.location}.\n"
    elsif @this_round_gold == 1 && @this_round_silver.zero?
      print "\t Found #{@this_round_gold} ounce of gold in #{graph.get_current_node.location}.\n"
    elsif @this_round_gold == 1 && @this_round_silver == 1
      print "\t Found #{@this_round_gold} ounce of gold and #{@this_round_silver} ounce of silver in #{graph.get_current_node.location}.\n"
    elsif @this_round_gold.zero? && @this_round_silver.zero?
      print "\t Found no precious metals in #{graph.get_current_node.location}.\n"
    elsif @this_round_silver > 1 && @this_round_gold.zero?
      print "\t Found #{@this_round_silver} ounces of silver in #{graph.get_current_node.location}.\n"
    elsif @this_round_gold > 1 && @this_round_silver.zero?
      print "\t Found #{@this_round_gold} ounces of gold in #{graph.get_current_node.location}.\n"
    else
      print "\t Found #{@this_round_gold} ounces of gold and #{@this_round_silver} ounces of silver in #{graph.get_current_node.location}.\n"
    end
  end

  def show_ending
    print "After #{@numdays} days, Prospector ##{@current_prospector} returned to San Francisco with:\n"
    print "\t#{@gold_found} ounces of gold.\n"
    print "\t#{@silver_found} ounces of silver.\n"
    cost = @gold_found * 20.67 + @silver_found * 1.31
    puts "\tHeading home with: $%.2f.\n\n" % [cost]
  end

  def show_location(graph, visits)
    if visits.zero?
      print 'Prospector ', @current_prospector, ' starting in Sutter Creek.\n'
    else
      print "Heading from #{@last_location} to #{graph.get_current_node.location}, holding #{@gold_found} ounces of gold and #{@silver_found} ounces of silver.\n"
    end
  end

  def play
    while @numprospectors > 0
      g = Graph.new(@seed)
      g = fill_graph(g)
      rush(g)
      @numprospectors -= 1
      @current_prospector += 1
    end
  end
  
  def get_silver_found
    @silver_found
  end
  
  def get_gold_found
    @gold_found
  end
end
