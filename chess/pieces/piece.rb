class Piece

  def initialize(color)
    @color = color
  end

  def to_s
    if @color == :white
      self.class::WHITE_CODE.encode("utf-8")
    else
      self.class::BLACK_CODE.encode("utf-8")
    end
  end

end
