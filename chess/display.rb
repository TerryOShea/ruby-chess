require 'colorize'
require_relative 'cursor'

class Display

  attr_accessor :cursor

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def render
    puts "  " + %w(A B C D E F G H).map {|el| " #{el} "}.join("")
    @board.grid.each_with_index do |row, row_index|
      str_row = []
      row.each_with_index do |square, col_index|
        string_rep = " #{square.to_s} "

        str_row << background(string_rep, row_index, col_index)
      end
      puts "#{8-row_index} #{str_row.join("")}"
    end
  end

  private

  def background(string_rep, row_index, col_index)
    cursor_row, cursor_col = @cursor.cursor_pos

    if @board.selected_piece
      selected_row, selected_col = @board.selected_piece
      if selected_row == row_index && selected_col == col_index
        return string_rep.colorize(:color => :black, :background => :yellow)
      end
    end

    if row_index == cursor_row && col_index == cursor_col
      return string_rep.colorize(:color => :black, :background => :cyan)
    end

    if (row_index + col_index) % 2 == 1
      return string_rep.colorize(:color => :black, :background => :light_black)
    end

    string_rep
  end


end
