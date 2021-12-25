# frozen_string_literal: true

module Move
  # king moves
  class OneUp < Base
    def position_candidates
      [position.down]
    end
  end
end
