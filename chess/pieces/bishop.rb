require_relative 'piece'
require_relative 'sliding_piece'

class Bishop < Piece

  include SlidingPiece

  WHITE_CODE = "\u2657"
  BLACK_CODE = "\u265D"

  def initialize(color, position, board)
    super
  end

  def move_dirs
    [:diagonal]
  end

end
