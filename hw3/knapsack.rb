first_line = true
items = {}
n = nil
idx = 1
ARGF.each do |line|
  if first_line
    W, n = line.split(" ").map { |token| token.to_i }
    first_line = false
    next
  end

  value, weight = line.split(" ").map { |token| token.to_i }
  items[idx] = {:value => value, :weight => weight}
  idx = idx + 1
end

# Initialize the 2D array
a = Array.new(2) { Array.new(W + 1) }
for x in 0..W
  a[0][x] = 0
end

# Compute the largest value of items that fit into the knapsack
for i in 1..n
  for x in 0..W
    # Case 1 when don't add current item to the knapsack
    val1 = a[(i - 1) % 2][x]
    val2 = 0
    if (x - items[i][:weight] >= 0)
      # Case 2 when we are able to fit current item into knapsack of capacity x
      val2 = a[(i - 1) % 2][x - items[i][:weight]] + items[i][:value]
    end 
    a[i % 2][x] = [val1, val2].max
  end
end

puts a[n % 2][W]
