require_relative 'piece'

class Rook < Piece

  WHITE_CODE = "\u2656"
  BLACK_CODE = "\u265C"

  def initialize(color)
    super(color)
  end

end
