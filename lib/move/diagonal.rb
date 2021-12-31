# frozen_string_literal: true

class Move
  # unlimited horizontal movement for a piece
  class Diagonal < Move
    def position_candidates
      [
        position.positions_up_left,
        position.positions_up_right,
        position.positions_down_left,
        position.positions_down_right
      ].map do |positions|
        legal_target_positions_in_line(positions)
      end.flatten
    end
  end
end
