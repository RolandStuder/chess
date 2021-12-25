# frozen_string_literal: true

module Move
  # king moves
  class OneDown < Base
    def legal_target_positions
      without_illegal_target_positions([position.down])
    end
  end
end
