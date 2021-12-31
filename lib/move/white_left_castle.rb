# frozen_string_literal: true

class Move
  # white queen side castle
  class WhiteLeftCastle < Castle
    private

    def king_target
      "C1"
    end

    def rook_origin
      "A1"
    end

    def rook_target
      "D1"
    end

    def in_between_positions
      Position.parse(%w[B1 C1 D1])
    end
  end
end
