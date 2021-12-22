require_relative 'field'

class Board
  def initialize
    create_fields
  end

  def get(col, row)
    position = Position.new(col, row)
    @fields.find { |field| field.col == position.letter && field.row == position.number }
  end

  private

  def create_fields
    @fields = (1..8).map.with_index do |row, row_index|
      ("A".."H").map.with_index do |col, col_index|
        color = (col_index % 2 + row_index % 2) % 2 == 1 ? :white : :black
        Field.new(col, row, color: color)
      end
    end.flatten
  end
end