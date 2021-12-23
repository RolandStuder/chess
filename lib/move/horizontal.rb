# frozen_string_literal: true

module Move
  # unlimited horizontal movement for a piece
  class Horizontal < Base
    def legal_moves
      legal_moves_in_line(position.positions_to_the_left) +
        legal_moves_in_line(position.positions_to_the_right)
    end
  end
end
