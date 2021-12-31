# frozen_string_literal: true

class Move
  # capture diagonally if occupied by enemy
  class DownDiagonalCapture < Move
    def position_candidates
      [
        (position.down&.left if occupied_by_enemy?(position.down&.left)),
        (position.down&.right if occupied_by_enemy?(position.down&.right))
      ].compact
    end

    def promotion_available?
      target&.rank == 1
    end
  end
end
