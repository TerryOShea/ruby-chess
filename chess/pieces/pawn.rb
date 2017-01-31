require_relative 'piece'

class Pawn < Piece

  WHITE_CODE = "\u2659"
  BLACK_CODE = "\u265F"

  def initialize(color)
    super(color)
  end

end
