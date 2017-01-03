class UnionFind
  class Component
    attr_reader :label
    attr_accessor :parent, :size

    def initialize(label)
      @label = label
      @parent = label
      @size = 1
    end

    def to_s
      "label=#{@label}, parent=#{@parent}, size=#{@size}"
    end
  end

  def initialize(size)
    @union_find = []
    @union_find << nil  # Not using 0 index
    (1..size).each do |label|
      @union_find << Component.new(label)
    end
  end

  # Returns name of group that x belongs to
  def find(x)
    get_leader(x).label
  end

  # Fuses groups x and y into a single one
  def union(x, y)
    return if find(x) == find(y)

    leader_x = get_leader(x)
    leader_y = get_leader(y)
    if leader_x.size >= leader_y.size
      leader_y.parent = leader_x.label
      leader_x.size = leader_x.size + leader_y.size
    else
      leader_x.parent = leader_y.label
      leader_y.size = leader_x.size + leader_y.size
    end
  end

  def get_leader(x)
    current = @union_find[x]
    parent = @union_find[current.parent]
    while current.label != parent.label
      current = parent
      parent = @union_find[current.parent]
    end 

    parent
  end

  private :get_leader
end
