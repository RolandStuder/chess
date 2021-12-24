# frozen_string_literal: true

# Square is a cell on the board, that can hold pieces
class Square
  attr_reader :row, :col
  attr_accessor :piece

  def initialize(col, row, color: :white)
    @row = row
    @col = col
    @color = color
  end

  def empty?
    piece.nil?
  end

  def occupied?
    !empty?
  end

  def white?
    @color == :white
  end

  def black?
    !white?
  end
end
