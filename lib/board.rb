# frozen_string_literal: true

# Board serves to keep the sate, of where all the pieces are
# rubocop:disable Metrics/ClassLength
class Board
  attr_reader :captured_pieces, :squares
  attr_accessor :en_passant_target_position

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

  def threatening_positions_for(position)
    piece = get(position).piece
    piece.move_types.map do |type|
      type.new(self, position).threatening_positions
    end.flatten
  end

  def positions_under_attack_from(color)
    squares_occupied_by(color).each do |square|
      threatening_positions_for(square.position)
    end.uniq
  end

  def move(origin, target)
    current_move = Move.from_board(self, origin, target)
    perform_board_operations(current_move.operations_on_board)
    @en_passant_target_position = current_move.en_passant_target_positions
  end

  def valid_move_for?(color, origin, target)
    return false unless squares_occupied_by(color).include?(get(origin))
    return false unless legal_target_positions_for(origin).include?(Position.parse(target))

    true
  end

  def squares_occupied_by(color)
    @squares.select { |square| square&.piece&.color == color }
  end

  def in_check?(color)
    opposite_color = color == :black ? :white : :black
    return false unless king_square(color)

    squares_occupied_by(opposite_color).any? do |square|
      threatening_positions_for(square.position).any? { |position| position == king_square(color).position }
    end
  end

  def in_checkmate?(color)
    return false unless king_square(color)
    return false unless in_check?(color)

    squares_occupied_by(color).map do |square|
      legal_target_positions_for(square.position)
    end.flatten.empty?
  end

  def in_stalemate?(color)
    return false unless king_square(color)
    return false if in_check?(color)

    squares_occupied_by(color).all? do |square|
      legal_target_positions_for(square.position).compact.empty?
    end
  end

  private

  def capture(target_square)
    return false if target_square.empty?

    @captured_pieces << target_square.piece.dup
    target_square.piece = nil
  end

  def perform_board_operations(operations)
    operations.each do |operation|
      case operation[:type]
      when :capture
        capture(get(operation[:target]))
      when :move
        move_operation(operation[:origin], operation[:target])
      end
    end
  end

  def move_operation(origin, target)
    origin_square = get(origin)
    target_square = get(target)

    piece = origin_square.piece
    piece.moved = true
    target_square.piece = piece
    origin_square.piece = nil
  end

  def create_squares
    @squares = 8.downto(1).map.with_index do |row, row_index|
      ("A".."H").map.with_index do |col, col_index|
        color = ((col_index % 2) + (row_index % 2)).odd? ? :black : :white
        Square.new(col + row.to_s, color: color)
      end
    end.flatten
  end

  def king_square(color)
    @squares.find { |square| square.piece == King.new(color) }
  end
end
# rubocop:enable Metrics/ClassLength
