require_relative 'piece'

class Pawn < Piece

  WHITE_CODE = "\u2659"
  BLACK_CODE = "\u265F"

  attr_accessor :turns

  def initialize(color, position, board)
    super
    @turns = 0
  end

  def moves
    moves_arr = []
    opposite_color = (@color == :white ? :black : :white)
    i = (@color == :black ? 1 : -1)

    if @board.empty?([@position[0] + i, @position[1]])
      moves_arr << [@position[0] + i, @position[1]]
    end

    if @board.empty?([@position[0] + i * 2, @position[1]])
      moves_arr << [@position[0] + i * 2, @position[1]] if @turns == 0
    end

    checking_pos = [
      [@position[0] + i, @position[1] + 1],
      [@position[0] + i, @position[1] - 1]
    ]

    checking_pos.each do |pos|
      if @board.in_bounds?(pos) && @board[pos].color == opposite_color
        moves_arr << pos
      end
    end

    moves_arr
  end
end
