Dir[File.dirname(__FILE__) + '/pieces/*.rb'].each {|file| require file }
require_relative 'display'

require 'colorize'

class Board

  attr_reader :grid

  PIECES = {
    rook: [[0, 0], [0, 7], [7, 0], [7, 7]],
    knight: [[0, 1], [0, 6], [7, 1], [7, 6]],
    bishop: [[0, 2], [0, 5], [7, 2], [7, 5]],
    queen: [[0, 3], [7, 4]],
    king: [[0, 4], [7, 3]],
  }

  def initialize
    @null_piece = NullPiece.instance
    @grid = Array.new(8) { Array.new(8) { @null_piece } }

    grid_setup
  end

  def grid_setup
    PIECES.each do |piece_name, positions|
      positions.each_with_index do |pos, i|
        color = (i < positions.length/2 ? :black : :white)
        self[pos] = eval(piece_name.to_s.capitalize).new(color, pos, self)
      end
    end
    (0..7).each { |col| self[[1, col]] = Pawn.new(:black, [1, col], self) }
    (0..7).each { |col| self[[6, col]] = Pawn.new(:white, [6, col], self) }
  end

  def move_piece(start_pos, end_pos)
    raise "no piece at that position" if self[start_pos].empty?
    raise "you can't go there!" unless valid_move(self[start_pos], start_pos, end_pos)

    self[start_pos], self[end_pos] = @null_piece, self[start_pos]
  end

  def valid_move(piece, start_pos, end_pos)
    in_bounds?(end_pos)
    # end_pos.? { |idx| idx < 0 || idx > 7 }
  end

  def []=(pos, val)
    row, col = pos
    @grid[row][col] = val
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def in_bounds?(pos)
    (0..1).all? {|idx| (0..7).include?(pos[idx]) }
  end

  def empty?(pos)
    self[pos].class == NullPiece

  end

end

if __FILE__ == $0
  b = Board.new
  # d = Display.new(b)
  # d.play
  pawn = b[[6,3]]
  p pawn.moves
end
