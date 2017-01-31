require_relative 'piece'
require_relative 'stepping_piece'

class Knight < Piece

  include SteppingPiece

  WHITE_CODE = "\u2658"
  BLACK_CODE = "\u265E"

  MOVE_DELTAS = [
    [1, 2],
    [2, 1],
    [1, -2],
    [2, -1],
    [-2, 1],
    [-2, -1],
    [-1, 2],
    [-1, -2]
  ]

  def initialize(color, position, board)
    super
  end

end
