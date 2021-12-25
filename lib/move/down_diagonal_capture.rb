# frozen_string_literal: true

module Move
  # capture diagonally if occupied by enemy
  class DownDiagonalCapture < Base
    def position_candidates
      [
        (position.down&.left if occupied_by_enemy?(position.down&.left)),
        (position.down&.right if occupied_by_enemy?(position.down&.right))
      ].compact
    end
  end
end
