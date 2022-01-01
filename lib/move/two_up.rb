# frozen_string_literal: true

class Move
  # move down two squares if not occupied
  class TwoUp < Move
    def position_candidates
      if no_piece_in_the_way? && target_piece_not_occupied?
        [position.up.up]
      else
        []
      end
    end

    def en_passant_target_positions
      position.up
    end

    def resets_half_turn_clock?
      true
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
