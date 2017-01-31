require 'colorize'
require_relative 'cursor'

class Display

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def render
    @board.grid.each do |row|
      puts row.map {|square| square.nil? ? " " : square.to_s }.join("|")
    end
  end
end
