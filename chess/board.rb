Dir[File.dirname(__FILE__) + '/pieces/*.rb'].each {|file| require file }
require_relative 'display'

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
    @grid = Array.new(8) { Array.new(8) }
    grid_setup
  end

  def grid_setup
    PIECES[:rook].each_with_index { |pos, i| self[pos] = Rook.new(i < 2 ? :black : :white) }
    PIECES[:knight].each_with_index { |pos, i| self[pos] = Knight.new(i < 2 ? :black : :white) }
    PIECES[:bishop].each_with_index { |pos, i| self[pos] = Bishop.new(i < 2 ? :black : :white) }
    PIECES[:queen].each_with_index { |pos, i| self[pos] = Queen.new(i < 1 ? :black : :white) }
    PIECES[:king].each_with_index { |pos, i| self[pos] = King.new(i < 1 ? :black : :white) }
    (0..7).each { |col| self[[1, col]] = Pawn.new(:black) }
    (0..7).each { |col| self[[6, col]] = Pawn.new(:white) }
  end

  def move_piece(start_pos, end_pos)
    raise "no piece at that position" if self[start_pos].nil?
    raise "you can't go there!" unless valid_move(self[start_pos], start_pos, end_pos)

    self[start_pos], self[end_pos] = nil, self[start_pos]
  end

  def valid_move(piece, start_pos, end_pos)
    return false if end_pos.any? { |idx| idx < 0 || idx > 7 }
    true
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

end

if __FILE__ == $0
  b = Board.new
  d = Display.new(b)
  d.render
end
