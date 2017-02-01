class HumanPlayer

  attr_reader :color, :name

  def initialize(color, name)
    @color = color
    @name = name
  end

  def opponent_color
    @color == :white ? :black : :white
  end

  def get_start_pos(display)
    get_pos(display)
  end

  def get_end_pos(display)
    get_pos(display)
  end

  def get_pos(display)
    pos = nil
    while pos.nil?
      display.render
      puts "#{@name}'s turn!"
      pos = display.cursor.get_input
      system("clear")
    end
    pos
  end

end
