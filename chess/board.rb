Dir[File.dirname(__FILE__) + '/pieces/*.rb'].each {|file| require file }
require_relative 'display'

require 'colorize'

class Board

  attr_accessor :grid, :selected_piece

  PIECES = {
    rook: [[0, 0], [0, 7], [7, 0], [7, 7]],
    knight: [[0, 1], [0, 6], [7, 1], [7, 6]],
    bishop: [[0, 2], [0, 5], [7, 2], [7, 5]],
    queen: [[0, 3], [7, 3]],
    king: [[0, 4], [7, 4]],
    pawn: [[1,0], [1,1], [1,2], [1,3], [1,4], [1,5], [1,6], [1,7],
           [6,0], [6,1], [6,2], [6,3], [6,4], [6,5], [6,6], [6,7]]
  }

  def initialize(grid = nil)
    @grid = grid || grid_setup
    @white_king_pos = find_king(:white)
    @black_king_pos = find_king(:black)
    @selected_piece = nil
  end

  def find_king(color)
    (0...8).each do |row|
      (0...8).each do |col|
        next if self[[row, col]].color != color
        return [row, col] if self[[row, col]].class == King
      end
    end
  end

  def grid_setup
    grid = Array.new(8) { Array.new(8) { NullPiece.instance } }

    PIECES.each do |piece_name, positions|
      positions.each_with_index do |pos, i|
        color = (i < positions.length/2 ? :black : :white)
        class_name = piece_name.to_s.capitalize
        grid[pos[0]][pos[1]] = eval(class_name).new(color, pos, self)
      end
    end
    grid
  end

  def move_piece(start_pos, end_pos)
    self[start_pos], self[end_pos] = NullPiece.instance, self[start_pos]

    if self[end_pos].class == Pawn
      self[end_pos].turns += 1
    end

    self[end_pos].position = end_pos.dup

    if self[end_pos].class == King
      if self[end_pos].color == :black
        @black_king_pos = end_pos
      else
        @white_king_pos = end_pos
      end
    end
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

  def in_check?(color)
    if color == :black
      king_pos = @black_king_pos
      opposite_color = :white
    else
      king_pos = @white_king_pos
      opposite_color = :black
    end

    (0...8).each do |row|
      (0...8).each do |col|
        next if self[[row, col]].color != opposite_color
        return true if self[[row, col]].moves.include?(king_pos)
      end
    end

    false
  end

  def checkmate?(color)

    return false unless in_check?(color)
    king_pos = (color == :black ? @black_king_pos : @white_king_pos)

    (0...8).each do |row|
      (0...8).each do |col|
        if self[[row, col]].color == color
          return false if self[[row, col]].valid_moves.length > 0
        end
      end
    end

    true
  end

  def clone_board
    copy = Board.new(@grid)
    copy.grid = clone_grid(copy)
    copy
  end

  def clone_grid(copy_board)
    grid_copy = []
    (0...8).each do |row|
      copy_row = []
      (0...8).each do |col|
        old_piece = self[[row, col]]
        if old_piece.class == NullPiece
          new_piece = NullPiece.instance
        else
          new_piece = old_piece.class.new(old_piece.color, old_piece.position, copy_board)
        end
        copy_row << new_piece
      end
      grid_copy << copy_row
    end
    grid_copy
  end

end
