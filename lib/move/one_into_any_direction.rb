# frozen_string_literal: true

module Move
  # king moves
  class OneIntoAnyDirection < Base
    def legal_target_positions
      positions = directions.map do |direction|
        position.go(*direction)
      end
      without_illegal_target_positions(positions.compact)
    end

    private

    def directions
      [
        :up, :down, :left, :right,
        %i[up left],
        %i[up right],
        %i[down left],
        %i[down right]
      ]
    end
  end
end
