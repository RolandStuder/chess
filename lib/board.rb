# frozen_string_literal: true

# Board serves to keep the sate, of where all the pieces are
class Board
  attr_reader :captured_pieces

  def self.with_setup
    FEN.new("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1").to_board(check_moved: false)
  end

  def self.from_fen(fen)
    FEN.new(fen).to_board
  end

  def initialize
    create_squares
    @captured_pieces = []
  end

  def get(position)
    position = Position.parse(position) if position.is_a? String
    @squares.find { |square| square.position == position }
  end

  def place(piece, position)
    get(position).piece = piece
  end

  def legal_target_positions_for(position)
    piece = get(position).piece
    piece.move_types.map do |type|
      type.new(self, position).legal_target_positions
    end.flatten
  end

  def move(origin, target)
    origin = Position.parse(origin)
    target = Position.parse(target)

    origin_square = get(origin)
    target_square = get(target)

    piece = origin_square.piece
    piece.moved = true
    capture(target_square)
    get(target).piece = piece
    origin_square.piece = nil
  end

  def squares_occupied_by(color)
    @squares.select { |square| square&.piece&.color == color }
  end

  def in_check?(color)
    king_square = find_king(color)
    return false unless king_square

    opposite_color = color == :black ? :white : :black
    squares_occupied_by(opposite_color).each do |square|
      return true if legal_target_positions_for(square.position).any? { |position| position == king_square.position }
    end
    false
  end

  def in_checkmate?(color)
    king_square = find_king(color)
    return false unless king_square
    return false unless in_check?(color)

    squares_occupied_by(color).map do |square|
      legal_target_positions_for(square.position)
    end.flatten.empty?
  end

  private

  def capture(target_square)
    return false if target_square.empty?

    @captured_pieces << target_square.piece
    target_square.piece = nil
  end

  def create_squares
    @squares = (1..8).map.with_index do |row, row_index|
      ("A".."H").map.with_index do |col, col_index|
        color = ((col_index % 2) + (row_index % 2)).odd? ? :white : :black
        Square.new(col + row.to_s, color: color)
      end
    end.flatten
  end

  def find_king(color)
    @squares.find { |square| square.piece == King.new(color) }
  end
end
