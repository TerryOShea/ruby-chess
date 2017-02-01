class Piece
  attr_reader :color
  attr_accessor :position

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

  def valid_moves
    moves.reject { |pos| move_into_check?(pos) }
  end

  def move_into_check?(end_pos)
    board_copy = @board.clone_board
    board_copy.move_piece(@position, end_pos)
    board_copy.in_check?(@color)
  end
end
