firstLine = true
nodeCount = 0
X = []
E = []
ARGF.each do |line|
  if firstLine
    nodeCount, _ = line.split(" ")
    nodeCount = nodeCount.to_i
    firstLine = false
    next
  end

  edge = {}
  u, v, cost = line.split(" ")
  edge["u"] = u.to_i
  edge["v"] = v.to_i
  edge["cost"] = cost.to_i
  E << edge 
end

cost = 0
X << 1
while X.length != nodeCount do
  minEdge = {}
  minEdge["cost"] = 1000000000
  x = nil
  E.each do |edge|
    if X.include?(edge["u"]) && !X.include?(edge["v"]) && edge["cost"] <= minEdge["cost"]
      x = edge["v"]
      minEdge = edge
    elsif X.include?(edge["v"]) && !X.include?(edge["u"]) && edge["cost"] <= minEdge["cost"]
      x = edge["u"]
      minEdge = edge
    end
  end

  X << x
  cost = cost + minEdge["cost"]
end

puts cost
