module SteppingPiece

  def moves
    row, col = @position
    output = []
    MOVE_DELTAS.each do |delta|
      pos_to_check = [row + delta[0], col + delta[1]]
      next unless @board.in_bounds?(pos_to_check)
      next unless @board[pos_to_check].color == @color
      output << potential_move
    end
    output
  end

end
