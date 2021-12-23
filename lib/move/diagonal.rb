# frozen_string_literal: true

module Move
  # unlimited horizontal movement for a piece
  class Diagonal < Base
    def legal_moves
      [
        position.positions_up_left,
        position.positions_up_right,
        position.positions_down_left,
        position.positions_down_right
      ].map do |positions|
        legal_moves_in_line(positions)
      end.flatten
    end
  end
end
