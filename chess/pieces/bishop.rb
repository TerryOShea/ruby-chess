require_relative 'piece'

class Bishop < Piece

  WHITE_CODE = "\u2657"
  BLACK_CODE = "\u265D"

  def initialize(color)
    super(color)
  end

end
