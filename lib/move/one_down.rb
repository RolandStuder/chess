# frozen_string_literal: true

class Move
  # king moves
  class OneDown < Move
    def position_candidates
      [(position.down unless board.get(position.down).occupied?)].compact
    end

    def promotion_available?
      target&.rank == 1
    end
  end
end
