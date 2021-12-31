# frozen_string_literal: true

class Move
  # king moves
  class OneIntoAnyDirection < Move
    def position_candidates
      directions.map do |direction|
        position.go(*direction)
      end.compact
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
