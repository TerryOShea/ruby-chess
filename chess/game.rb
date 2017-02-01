require_relative 'board'
require_relative 'display'
require_relative 'human_player'

class Game

  def initialize(players)
    @board = Board.new
    @display = Display.new(@board)
    @players = players
    @current_player = @players[0]

  end

  def switch_players
    @current_player = (@current_player == @players[0] ? @players[1] : @players[0])
  end

  def play
    system("clear")
    until won?

      begin
        start_pos = @current_player.get_start_pos(@display)
        @board.selected_piece = start_pos
        end_pos = @current_player.get_end_pos(@display)
        @board.selected_piece = nil

        if @board[start_pos].color == @current_player.opponent_color
          raise RuntimeError, "you can't move your opponent's piece!"
        end

        if @board.empty?(start_pos)
          raise RuntimeError, "no piece at that position"
        end

        unless @board.in_bounds?(end_pos)
          raise RuntimeError, "you can't go off the board!"
        end

        if start_pos == end_pos
          raise RuntimeError, "x"
        end

        unless @board[start_pos].moves.include?(end_pos)
          raise RuntimeError, "Invalid, you can't go there!"
        end

        unless @board[start_pos].valid_moves.include?(end_pos)
          raise RuntimeError, "you'd be in check!"
        end

        @board.move_piece(start_pos, end_pos)
      rescue RuntimeError => e
        puts e.message unless e.message == "x"
      retry
      end

      switch_players
    end

    @display.render
    puts "#{winner.name} won!"
  end

  def won?
    @board.checkmate?(:black) || @board.checkmate?(:white)
  end

  def winner
    winner_color = (@board.checkmate?(:black) ? :white : :black)
    return @players[0] if @players[0].color == winner_color
    @players[1]
  end

end

if __FILE__ == $0
  terry = HumanPlayer.new(:black, "Terry")
  sweta = HumanPlayer.new(:white, "Sweta")
  game = Game.new([terry, sweta])
  game.play
end
