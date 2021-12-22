class Field
  attr_reader :row, :col
  def initialize(col, row, color: :white)
    @row = row
    @col = col
    @color = color
  end

  def white?
    @color == :white
  end

  def black?
    !white?
  end
end