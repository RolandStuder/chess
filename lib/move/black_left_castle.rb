# frozen_string_literal: true

class Move
  # black queen side castle
  class BlackLeftCastle < Castle
    private

    def king_target
      "C8"
    end

    def rook_origin
      "A8"
    end

    def rook_target
      "D8"
    end

    def in_between_positions
      Position.parse(%w[B8 C8 D8])
    end
  end
end
