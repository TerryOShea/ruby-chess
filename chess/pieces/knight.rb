require_relative 'piece'

class Knight < Piece

  WHITE_CODE = "\u2658"
  BLACK_CODE = "\u265E"

  def initialize(color)
    super(color)
  end

end
