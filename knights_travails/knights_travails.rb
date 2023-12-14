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
CURRENT_POSITION = [2,2]

def show_available_positions
  positions = []
  for i in POSSIBLE_MOVES
    target_move = i
      for j in (0..1)
        available_moves = (target_move[j] + CURRENT_POSITION[j]) if target_move
        positions << available_moves if available_moves.between?(0, 7)
      end
  end
  targets.each_slice(2).to_a.uniq
end

p show_available_positions
