first_line = true
$items = {}
n = nil
idx = 1
ARGF.each do |line|
  if first_line
    W, n = line.split(" ").map { |token| token.to_i }
    first_line = false
    next
  end

  value, weight = line.split(" ").map { |token| token.to_i }
  $items[idx] = {:value => value, :weight => weight}
  idx = idx + 1
end

memo = Array.new(W + 1, 0)
i = 1
while i <= n
  x = W
  while x >= 0
    val1 = memo[x]
    val2 = 0
    if ($items[i][:weight] <= x)
      val2 = memo[x - $items[i][:weight]] + $items[i][:value]
    end
    memo[x] = val1 > val2 ? val1 : val2
    x -= 1
  end
  i += 1
end

puts memo[W]
