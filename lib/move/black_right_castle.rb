# frozen_string_literal: true

class Move
  # black king side castle
  class BlackRightCastle < Castle
    private

    def king_target
      "G8"
    end

    def rook_origin
      "H8"
    end

    def rook_target
      "F8"
    end

    def in_between_positions
      Position.parse(%w[F8 G8])
    end
  end
end
