# frozen_string_literal: true

# Base class for chess pieces
class Piece
  attr_reader :color

  def initialize(color = :white)
    @color = color.to_sym
  end

  def black?
    color == :black
  end

  def white?
    color == :white
  end
end
