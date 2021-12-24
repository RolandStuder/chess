# frozen_string_literal: true

require_relative 'field'

# Board serves to keep the sate, of where all the pieces are
class Board
  attr_reader :captured_pieces

  def initialize
    create_fields
    @captured_pieces = []
  end

  def get(position)
    position = Position.parse(position) if position.is_a? String
    @fields.find { |field| field.col == position.letter && field.row == position.number }
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

    origin_field = get(origin)
    target_field = get(target)
    raise "Illegal move" unless legal_moves_for(origin).include? target

    piece = origin_field.piece
    piece.moved = true
    capture(target_field)
    get(target).piece = piece
    origin_field.piece = nil
  end

  private

  def capture(target_field)
    return false if target_field.empty?

    @captured_pieces << target_field.piece
    target_field.piece = nil
  end

  def create_fields
    @fields = (1..8).map.with_index do |row, row_index|
      ("A".."H").map.with_index do |col, col_index|
        color = ((col_index % 2) + (row_index % 2)).odd? ? :white : :black
        Field.new(col, row, color: color)
      end
    end.flatten
  end
end
