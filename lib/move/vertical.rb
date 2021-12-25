# frozen_string_literal: true

module Move
  # unlimited vertical movement for a piece
  class Vertical < Base
    def legal_target_positions
      legal_target_positions_in_line(position.positions_upwards) +
        legal_target_positions_in_line(position.positions_downwards)
    end
  end
end
