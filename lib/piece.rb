# frozen_string_literal: true

# Base class for chess pieces
class Piece
  attr_reader :color
  attr_accessor :moved

  def initialize(color = :white)
    @color = color.to_sym
    @moved = false
  end

  def black?
    color == :black
  end

  def white?
    color == :white
  end

  def moved?
    @moved == true
  end
end
