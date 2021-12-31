# frozen_string_literal: true

# Display the game state
class Display
  def initialize(board)
    @board = board
  end

  def board
    ranks = @board.squares.each_slice(8).to_a.map do |file|
      file.map(&:to_s).join
    end
    ranks.map!.with_index(0) do |rank, index|
      "#{8 - index} #{rank}"
    end
    ranks.unshift("  #{('A'..'H').to_a.map { |file| " #{file} " }.join}")
    ranks
  end
end
