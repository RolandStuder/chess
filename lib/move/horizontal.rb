# frozen_string_literal: true

module Move
  # unlimited horizontal movement for a piece
  class Horizontal < Base
    def position_candidates
      legal_target_positions_in_line(position.positions_to_the_left) +
        legal_target_positions_in_line(position.positions_to_the_right)
    end
  end
end
