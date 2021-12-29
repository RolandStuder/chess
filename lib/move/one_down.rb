# frozen_string_literal: true

module Move
  # king moves
  class OneDown < Base
    def position_candidates
      [(position.down unless board.get(position.down).occupied?)].compact
    end
  end
end
