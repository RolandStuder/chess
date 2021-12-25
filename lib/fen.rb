# frozen_string_literal: true

# helper to parse and create boards from Forsyth–Edwards Notation
# https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation
class FEN
  def initialize(string)
    @raw = string
    raise "Invalid notation, should have 6 parts, but has #{parts.size}" unless parts.size == 6
  end

  # @param check_moved [boolean] will not set any moved status of pieces
  #
  # we used check_moved false to initiate a board with the start state from a FEN, as we use
  # Board.with_setup in this method, we need this to prevent an infinite loop
  def to_board(check_moved: true)
    board = Board.new
    pieces_with_positions.each do |piece, position|
      piece.moved = true if check_moved && (Board.with_setup.get(position).piece != piece)
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
      files_index += 1
    end
    squares
  end

  def parts
    @raw.split
  end
end
