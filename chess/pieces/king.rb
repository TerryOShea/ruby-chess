require_relative 'piece'

class King < Piece

  WHITE_CODE = "\u2654"
  BLACK_CODE = "\u265A"

  def initialize(color)
    super(color)
  end

end
