# frozen_string_literal: true

# Square is a cell on the board, that can hold pieces
class Square
  attr_reader :position
  attr_accessor :piece

  def initialize(position, color: :white)
    @color = color
    @position = Position.parse(position)
  end

  def empty?
    piece.nil?
  end

  def occupied?
    !empty?
  end

  def occupied_by?(color)
    piece && piece.color == color
  end

  def white?
    @color == :white
  end

  def black?
    !white?
  end
end
