# frozen_string_literal: true

module Move
  # knight moves in ls
  class Knight < Base
    def legal_moves
      positions = directions.map do |direction|
        position.go(*direction)
      end
      without_illegal_moves(positions.compact)
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
