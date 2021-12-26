# frozen_string_literal: true

module Move
  # unlimited horizontal movement for a piece
  class Castle < Base
    def position_candidates
      unless allowed?
        position_candidates
      else
        []
      end
    end

    def operations_on_board
      [
        { type: :move, origin: position, target: target },
        { type: :move, origin: rook_origin, target: rook_target }
      ]
    end

    def position_candidates
      [Position.parse(king_target)]
    end

    private


    def allowed?
      king_not_moved? && rook_not_moved? && no_blocking_pieces?
    end

    def king_not_moved?
      !piece.moved?
    end

    def rook_not_moved?
      board.get("A8").piece.moved?
    end

    def no_blocking_pieces?
      in_between_positions.none do |pos|
        board.get(pos).occupied?
      end
    end

    def in_between_positions
      Position.parse("B8", "D8")
    end
  end
end
