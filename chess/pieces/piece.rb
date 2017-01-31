class Piece
  attr_reader :color, :position
  def initialize(color, position, board)
    @color = color
    @position = position
    @board = board
  end

  def to_s
    if @color == :white
      self.class::WHITE_CODE.encode("utf-8")
    elsif @color == :black
      self.class::BLACK_CODE.encode("utf-8")
    else
      " "
    end
  end

end
