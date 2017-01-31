require_relative 'piece'
require_relative 'stepping_piece'

class King < Piece

  include SteppingPiece

  WHITE_CODE = "\u2654"
  BLACK_CODE = "\u265A"

  MOVE_DELTAS = [
    [0, 1],
    [0, -1],
    [1, 0],
    [-1, 0],
    [1, 1],
    [1, -1],
    [-1, 1],
    [-1, -1]
  ]

  def initialize(color, position, board)
    super
  end

end
