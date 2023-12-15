class Node
  attr_reader :position, :parent
  POSSIBLE_MOVES = [
    [1, 2],
    [2, 1],
    [2, -1],
    [1, -2],
    [-1, -2],
    [-2, -1],
    [-2, 1],
    [-1, 2]
  ]

  def initialize(position, parent)
    @position = position
    @parent = parent
  end

  def available_positions
    positions = []
    for i in POSSIBLE_MOVES
        for j in (0..1)
          available_moves = (i[j] + @position[j]) if i
          positions << available_moves
        end
    end
    positions.each_slice(2)
      .to_a
      .select { |e| valid?(e) }
      .map { |e| Node.new(e, self) }
  end

  def valid?(position)
    position[0].between?(0, 7) && position[1].between?(0, 7)
  end

  def self.knight_move(start, end_pos)
    queue = []
    node = Node.new(start, nil)
    until node.position == end_pos
      node.available_positions.each { |e| queue.push(e) }
      node = queue.shift
    end
    until node.parent.nil?
      p node.position
      node = node.parent
    end
  end
end
# Node.knight_move([0,0], [7,3])
