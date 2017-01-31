require_relative 'piece'
require_relative 'sliding_piece'

class Rook < Piece

  include SlidingPiece

  WHITE_CODE = "\u2656"
  BLACK_CODE = "\u265C"

  def initialize(color, position, board)
    super
  end

  def move_dirs
    [:straight]
  end

end
