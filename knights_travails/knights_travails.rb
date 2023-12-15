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

board = Array.new(8) {Array(0..8)}

def available_positions(position)
  positions = []
  for i in POSSIBLE_MOVES
      for j in (0..1)
        available_moves = (i[j] + position[j]) if i
        positions << available_moves
      end
  end
  positions.each_slice(2)
    .to_a
    .select { |e| valid?(e) }
end

def populate_board(board)
  board.each_with_index do |e, i|
    e.map!.with_index { |ie, ii| ie = show_available_positions([i, ii]) }
  end
  board
end

def valid?(position)
  position[0].between?(0, 7) && position[1].between?(0, 7)
end

populate_board(board)
p board[1][0]
