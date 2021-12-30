# frozen_string_literal: true

require 'colorize'

# Square is a cell on the board, that can hold pieces
class Square
  attr_reader :position
  attr_accessor :piece

  def initialize(position, color: :white)
    @color = color
    @position = Position.parse(position)
  end

  def to_s
    piece_symbol = (piece ? piece.to_s : " ").light_white
    output = " #{piece_symbol} \n"
    output.split("\n").map { |row| white? ? row.on_light_blue : row.on_blue }.join("\n")
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
