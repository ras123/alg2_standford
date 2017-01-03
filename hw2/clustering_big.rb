require_relative 'union_find.rb'

node_count = nil
union_find = nil
first_line = true
nodes = {}
node_label = 1
ARGF.each do |line|
  if first_line
    node_count = line.to_i
    union_find = UnionFind.new(node_count)
    first_line = false
    next
  end

  binary_str = line.gsub(/\s+/, "")
  nodes[binary_str.to_i(2)] = node_label
  node_label = node_label + 1
end

def get_permutations(position)
  permutations = []
  (0...24).each do |i|
    permutation = position ^ (1 << i)
    permutations << permutation
    ((i + 1)...24).each do |j|
      permutations << (permutation ^ (1 << j))
    end 
  end

  permutations
end

start = Time.now
fuse_count = 0
nodes.each do |position, label|
  permutations = get_permutations(position)
  permutations.each do |permutation|
    if nodes.include?(permutation)
      permutation_label = nodes[permutation]
      if union_find.find(label) != union_find.find(permutation_label)
        union_find.union(label, permutation_label)
        fuse_count = fuse_count + 1
      end
    end
  end
end

finish = Time.now
puts "Number of clusters is #{nodes.length - fuse_count}, #{finish - start}s"
