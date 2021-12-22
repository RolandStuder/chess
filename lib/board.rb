# frozen_string_literal: true

require_relative 'field'

# Board serves to keep the sate, of where all the pieces are
class Board
  def initialize
    create_fields
  end

  def get(position)
    position = Position.parse(position) if position.is_a? String
    @fields.find { |field| field.col == position.letter && field.row == position.number }
  end

  def place(piece, position)
    position = Position.parse(position) if position.is_a? String
    get(position).piece = piece
  end

  private

  def create_fields
    @fields = (1..8).map.with_index do |row, row_index|
      ("A".."H").map.with_index do |col, col_index|
        color = ((col_index % 2) + (row_index % 2)).odd? ? :white : :black
        Field.new(col, row, color: color)
      end
    end.flatten
  end
end
