# frozen_string_literal: true

module Move
  # capture diagonally if occupied by enemy
  class UpDiagonalCapture < Base
    def position_candidates
      [
        (position.up&.left if occupied_by_enemy?(position.up&.left)),
        (position.up&.right if occupied_by_enemy?(position.up&.right))
      ].compact
    end
  end
end
