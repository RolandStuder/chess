# frozen_string_literal: true

class Move
  # unlimited vertical movement for a piece
  class Vertical < Move
    def position_candidates
      legal_target_positions_in_line(position.positions_upwards) +
        legal_target_positions_in_line(position.positions_downwards)
    end
  end
end
