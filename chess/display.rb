require 'colorize'
require_relative 'cursor'

class Display

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def render
    @board.grid.each_with_index do |row, row_index|
      str_row = []
      row.each_with_index do |square, col_index|
        string_rep = get_string_rep(square)

        str_row << background(string_rep, row_index, col_index)
      end
      puts str_row.join("")
    end
  end

  def play
    while true
      system("clear")
      render
      @cursor.get_input
    end
  end


  private

  def get_string_rep(square)
    if square.nil?
      string_rep = "   "
    else
      string_rep = " #{square.to_s} "
    end
  end

  def background(string_rep, row_index, col_index)
    cursor_row, cursor_col = @cursor.cursor_pos

    if row_index == cursor_row && col_index == cursor_col
      return string_rep.colorize(:color => :black, :background => :green)
    end

    if (row_index + col_index) % 2 == 1
      return string_rep.colorize(:color => :black, :background => :light_black)
    end

    string_rep
  end


end
