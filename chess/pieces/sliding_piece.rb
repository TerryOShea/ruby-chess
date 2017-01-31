module SlidingPiece

  DIAG_DELTAS = [
    [1,1],
    [1, -1],
    [-1,-1],
    [-1, 1],
  ]

  STR_DELTAS = [
    [1, 0],
    [0, 1],
    [-1, 0],
    [0, -1],
  ]

  def moves
    output = []
    if move_dirs.include?(:diagonal)
      output.concat(diagonals)
    end
    if move_dirs.include?(:straight)
      output.concat(straights)
    end
    output
  end

  def diagonals
    find_reachable_moves(DIAG_DELTAS)
  end

  def straights
    find_reachable_moves(STR_DELTAS)
  end

  def find_reachable_moves(deltas)
    row, col = @position
    output = []
    deltas.each do |delta|
      i = 1
      delta_output = []

      pos_to_check = [row + (delta[0] * i), col + (delta[1] * i)]

      while @board.in_bounds?(pos_to_check)
        break if @board[pos_to_check].color == @color
        delta_output << pos_to_check
        i += 1
        pos_to_check = [row + (delta[0] * i), col + (delta[1] * i)]
        if delta_output.length > 0
          opposite_color = (@color == :white ? :black : :white)
          break if @board[delta_output.last].color == opposite_color
        end
      end

      output.concat(delta_output)

    end
    output
  end

end
