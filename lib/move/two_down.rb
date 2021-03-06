# frozen_string_literal: true

class Move
  # move down two squares if not occupied
  class TwoDown < Move
    def position_candidates
      if no_piece_in_the_way? && target_piece_not_occupied?
        [position.down.down]
      else
        []
      end
    end

    def en_passant_target_positions
      position.down
    end

    def resets_half_turn_clock?
      true
    end

    private

    def no_piece_in_the_way?
      position.down && !occupied?(position.down)
    end

    def target_piece_not_occupied?
      position.down.down && !occupied?(position.down.down)
    end
  end
end
