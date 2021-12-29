# frozen_string_literal: true

# helper to parse and create boards from Forsyth–Edwards Notation
# https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation
class FEN
  attr_reader :board

  def initialize(string)
    @raw = string
    raise "Invalid notation, should have 6 parts, but has #{parts.size}" unless parts.size == 6
  end

  # @param check_moved [boolean] will not set any moved status of pieces
  #
  # we used check_moved false to initiate a board with the start state from a FEN, as we use
  # Board.with_setup in this method, we need this to prevent an infinite loop
  def to_board(check_moved: true)
    @board = Board.new
    pieces_with_positions.each do |piece, position|
      piece.moved = true if check_moved && (Board.with_setup.get(position).piece != piece)
      board.place(piece, position)
    end
    remove_castling_rights
    set_en_passent_target_position
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

  # rubocop:disable Metrics/MethodLength
  def rank_to_pieces_with_position(rank_number, rank_string)
    squares = []
    files_index = 0
    rank_string.chars.map do |char|
      if char.to_i.positive?
        files_index += char.to_i
      else
        squares << [Piece.from_fen(char), Position.parse(("A".."H").to_a[files_index] + rank_number.to_s)]
        files_index += 1
      end
    end
    squares
  end
  # rubocop:enable Metrics/MethodLength

  def remove_castling_rights
    move_rook_at("H8") unless parts[2].include? "k"
    move_rook_at("A8") unless parts[2].include? "q"
    move_rook_at("H1") unless parts[2].include? "K"
    move_rook_at("A1") unless parts[2].include? "Q"
  end

  def set_en_passent_target_position
    board.en_passant_target_position = Position.parse(parts[3])
  end

  def move_rook_at(position)
    board.get(position).piece && board.get(position).piece.moved = true
  end

  def parts
    @raw.split
  end
end
