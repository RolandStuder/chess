# frozen_string_literal: true

# Board serves to keep the sate, of where all the pieces are
class Board
  attr_reader :captured_pieces

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

  def legal_moves_for(position)
    piece = get(position).piece
    piece.move_types.map do |type|
      type.new(self, position).legal_moves
    end.flatten
  end

  def move(origin, target)
    origin = Position.parse(origin)
    target = Position.parse(target)

    origin_square = get(origin)
    target_square = get(target)
    raise "Illegal move" unless legal_moves_for(origin).include? target

    piece = origin_square.piece
    piece.moved = true
    capture(target_square)
    get(target).piece = piece
    origin_square.piece = nil
  end

  def squares_occupied_by(color)
    @squares.select { |square| square&.piece&.color == color }
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
end
