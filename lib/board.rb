require_relative 'field'

class Board
  def initialize
    @fields = 8.downto(1).map do |row|
      ("a".."h").map do |col|
        Field.new(col, row)
      end
    end.flatten
  end

  def get(col, row)
    @fields.find { |field| field.col.downcase == col.downcase && field.row.to_s == row.to_s }
  end
end