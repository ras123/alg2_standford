first_line = true
edges = {}
vertices = []

class Vertex
  attr_accessor :id, :weight, :edges

  def initialize(id)
    @id = id
    @edges = []
  end
end

class Edge
  attr_accessor :cost, :head

  def initialize(cost, head)
    @cost = cost
    @head = head
  end
end

ARGF.each do |line|
  if first_line
    N, E = line.split(" ").map { |token| token.to_i }
    first_line = false
    next
  end

  tail, head, cost = line.split(" ").map &:to_i
  if vertices[tail].nil?
    vertex = Vertex.new(tail)
    vertex.edges << Edge.new(cost, head)
    vertices[tail] = vertex
  else
    vertices[tail].edges << Edge.new(cost, head)
  end
end

# Add a new source vertex having a 0 length edge to all other vertices
sourceVertex = Vertex.new(0)
(1..N).each do |v|
  sourceVertex.edges << Edge.new(0, v)
end
vertices[0] = sourceVertex

# Run Bellman-Ford algorithm to compute vertex weights

# Reweight edges using the vertex weights

# Run Dikstra algorithm for every vertex
