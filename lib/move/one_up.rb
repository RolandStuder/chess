# frozen_string_literal: true

class Move
  # king moves
  class OneUp < Move
    def position_candidates
      [(position.up unless board.get(position.up).occupied?)].compact
    end

    def promotion_available?
      target&.rank == 8
    end
  end
end
