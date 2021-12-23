# frozen_string_literal: true

# Field is a cell on the board, that can hold pieces
class Field
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

  def white?
    @color == :white
  end

  def black?
    !white?
  end
end
