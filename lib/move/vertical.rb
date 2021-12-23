# frozen_string_literal: true

module Move
  # unlimited vertical movement for a piece
  class Vertical < Base
    def legal_moves
      legal_moves_in_line(position.positions_upwards) +
        legal_moves_in_line(position.positions_downwards)
    end
  end
end
