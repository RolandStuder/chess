# frozen_string_literal: true

# helper to parse and create boards from Forsyth–Edwards Notation
# https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation
class FEN
  def initialize(string)
    @raw = string
    raise "Invalid notation, should have 6 parts, but has #{parts.size}" unless parts.size == 6
  end

  # a array of piece_name, color, and position
  def to_squares
    squares = []
    ranks = parts.first.split("/")
    ranks.each.with_index do |rank, index|
      squares = rank_to_pieces_with_position(index, rank, squares)
    end
    squares
  end

  private

  def rank_to_pieces_with_position(index, rank, squares)
    rank_number = 8 - index
    files_index = 0
    rank.chars.each do |char|
      if char.to_i.positive?
        files_index += char.to_i
        next
      end
      squares << [Piece.new, Position.parse(("A".."H").to_a[files_index] + rank_number.to_s)]
    end
    squares
  end

  def parts
    @raw.split
  end
end
