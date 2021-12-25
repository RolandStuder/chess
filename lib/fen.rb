# frozen_string_literal: true

# helper to parse and create boards from Forsyth–Edwards Notation
# https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation
class FEN
  def initialize(string)
    @raw = string
    raise "Invalid notation, should have 6 parts, but has #{parts.size}" unless parts.size == 6
  end

  def to_board
    board = Board.new
    pieces_with_positions.each do |piece, position|
      board.place(piece, position)
    end
    board
  end

  private

  # a array of piece, and position
  def pieces_with_positions
    result = []
    fem_ranks = parts.first.split("/")
    8.downto(1).each do |rank_number|
      result += rank_to_pieces_with_position(rank_number, fem_ranks[8 - rank_number])
    end
    result
  end

  def rank_to_pieces_with_position(rank_number, rank_string)
    squares = []
    files_index = 0
    rank_string.chars.each do |char|
      if char.to_i.positive?
        files_index += char.to_i
        next
      end
      squares << [Piece.from_fen(char), Position.parse(("A".."H").to_a[files_index] + rank_number.to_s)]
    end
    squares
  end

  def parts
    @raw.split
  end
end
