# frozen_string_literal: true

module Move
  # unlimited horizontal movement for a piece
  class BlackLeftCastle < Castle
    private
    def king_target
      "B8"
    end

    def rook_origin
      "A8"
    end

    def rook_target
      "C8"
    end

    def in_between_positions
      Position.parse("B8", "D8")
    end
  end
end
