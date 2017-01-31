require_relative 'piece'
require_relative 'sliding_piece'

class Queen < Piece

  include SlidingPiece

  WHITE_CODE = "\u2655"
  BLACK_CODE = "\u265B"

  def initialize(color, position, board)
    super
  end

  def move_dirs
    [:diagonal, :straight]
  end

end
