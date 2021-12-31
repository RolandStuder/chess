# frozen_string_literal: true

class Move
  # unlimited horizontal movement for a piece
  class Castle < Move
    def position_candidates
      if disallowed?
        []
      else
        [Position.parse(king_target)]
      end
    end

    def operations_on_board
      [
        { type: :move, origin: position, target: target },
        { type: :move, origin: rook_origin, target: rook_target }
      ]
    end

    private

    def disallowed?
      king_moved? || rook_moved? || blocking_pieces? || threatened_positions_in_between?
    end

    def king_moved?
      piece.moved?
    end

    def rook_moved?
      return true unless board.get(rook_origin).piece

      board.get(rook_origin).piece.moved?
    end

    def blocking_pieces?
      in_between_positions.any? do |pos|
        board.get(pos).occupied?
      end
    end

    def threatened_positions_in_between?
      opposite_color = piece.color == :white ? :black : :white
      in_between_positions.any? do |pos|
        board.positions_under_attack_from(opposite_color).include? pos
      end
    end
  end
end
