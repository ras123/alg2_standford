require_relative 'union_find.rb'

class Edge
  attr_reader :node1, :node2, :cost

  def initialize(node1, node2, cost)
    @node1 = node1
    @node2 = node2
    @cost = cost
  end
end

node_count = nil
union_find = nil
first_line = true
edges = []
ARGF.each do |line|
  if first_line
    node_count = line.to_i
    union_find = UnionFind.new(node_count)
    first_line = false
    next
  end

  node1, node2, cost = line.split(" ")
  edges << Edge.new(node1.to_i, node2.to_i, cost.to_i)
end

# Sort edges in increasing order of cost
edges.sort! do |edge1, edge2| 
  case 
  when edge1.cost < edge2.cost
    -1 
  else
    1 
  end 
end

# Compute maximum spacing of a 4-clustering
k = 4
fuse_count = 0
edges.each_with_index do |edge, idx|
  if union_find.find(edge.node1) != union_find.find(edge.node2)
    if fuse_count == node_count - k
      puts "Maximum spacing: #{edge.cost}"
      break
    else
      union_find.union(edge.node1, edge.node2)
      fuse_count = fuse_count + 1
    end
  end
end
