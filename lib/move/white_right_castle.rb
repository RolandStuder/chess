# frozen_string_literal: true

class Move
  # white queen side castle
  class WhiteRightCastle < Castle
    private

    def king_target
      "G1"
    end

    def rook_origin
      "H1"
    end

    def rook_target
      "F1"
    end

    def in_between_positions
      Position.parse(%w[F1 G1])
    end
  end
end
