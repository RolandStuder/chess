# frozen_string_literal: true

module Move
  # king moves
  class OneUp < Base
    def legal_moves
      without_illegal_moves([position.down])
    end
  end
end
