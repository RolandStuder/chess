# frozen_string_literal: true

class Move
  # knight moves in ls
  class Knight < Move
    def position_candidates
      directions.map do |direction|
        position.go(*direction)
      end.compact
    end

    private

    def directions
      [
        %i[up up right],
        %i[right right up],
        %i[right right down],
        %i[down down right],
        %i[down down left],
        %i[left left down],
        %i[left left up],
        %i[up up left]
      ]
    end
  end
end
