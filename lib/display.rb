# frozen_string_literal: true

# Display the game state
class Display
  def initialize(board)
    @board = board
  end

  def board
    # ugly puts supports multi line high string representations of squres
    @board.squares.each_slice(8).to_a.map do |file|
      lines = Array.new(file.first.to_s.split("\n").size, "")

      file.map do |square|
        square.to_s.split("\n").each.with_index do |row_row, index|
          lines[index] += row_row
        end
      end
      lines
    end.flatten.join("\n")
  end
end
