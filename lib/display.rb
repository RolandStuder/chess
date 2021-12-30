# frozen_string_literal: true

# Display the game state
class Display
  def initialize(board)
    @board = board
  end

  def board
    @board.squares.each_slice(8).to_a.map do |file|
      file.map(&:to_s).join
    end
  end
end
