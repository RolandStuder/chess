# frozen_string_literal: true

module Move
  # move down two squares if not occupied
  class TwoUp < Base
    def position_candidates
      if no_piece_in_the_way? && target_piece_not_occupied?
        [position.up.up]
      else
        []
      end
    end

    private

    def no_piece_in_the_way?
      position.up && !occupied?(position.up)
    end

    def target_piece_not_occupied?
      position.up.up && !occupied?(position.up.up)
    end
  end
end
