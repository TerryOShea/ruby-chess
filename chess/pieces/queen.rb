require_relative 'piece'

class Queen < Piece

  WHITE_CODE = "\u2655"
  BLACK_CODE = "\u265B"

  def initialize(color)
    super(color)
  end

end
