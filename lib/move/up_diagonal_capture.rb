# frozen_string_literal: true

class Move
  # capture diagonally if occupied by enemy
  class UpDiagonalCapture < Move
    def position_candidates
      [
        (position.up&.left if occupied_by_enemy?(position.up&.left)),
        (position.up&.right if occupied_by_enemy?(position.up&.right))
      ].compact
    end

    def promotion_available?
      target&.rank == 8
    end
  end
end
