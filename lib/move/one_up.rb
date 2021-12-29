# frozen_string_literal: true

module Move
  # king moves
  class OneUp < Base
    def position_candidates
      [(position.up unless board.get(position.up).occupied?)].compact
    end
  end
end
