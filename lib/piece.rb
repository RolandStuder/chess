# frozen_string_literal: true

# Base class for chess pieces
class Piece
  attr_reader :color
  attr_accessor :moved

  # rubocop:disable Metrics/CyclomaticComplexity
  def self.from_fen(char)
    color = char.downcase == char ? :black : :white
    case char.upcase
    when "R" then Rook.new(color)
    when "N" then Knight.new(color)
    when "Q" then Queen.new(color)
    when "K" then King.new(color)
    when "B" then Bishop.new(color)
    when "P" then Pawn.new(color)
    else raise "invalid piece representation"
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity

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

  def ==(other)
    color == other.color && self.class == other.class
  end
end
