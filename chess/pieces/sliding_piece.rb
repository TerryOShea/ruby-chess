module SlidingPiece
  def moves
    output = []
    if move_dirs.include?(:diagonal)
      output <<
    @current_pos
  end

  def diagonals
    row, col = @current_pos
    output = []

    i = 1
    while row - i > 0 || col - i
      output << [row-i, col-i]
      i += 1
    end





    (row...8).each do |i|
      output << [row+i, col+i]
    end



  end
end
