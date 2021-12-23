# frozen_string_literal: true

module Move
  # unlimited horizontal movement for a piece
  class Horizontal < Base
    def legal_moves
      legal_moves_from(position.positions_to_the_left) +
        legal_moves_from(position.positions_to_the_right)
    end

    private

    def legal_moves_from(positions)
      legals = []
      positions.each do |target_position|
        break if occupied_by_friend?(target_position)

        legals << target_position
        break if occupied_by_enemy?(target_position)
      end
      legals
    end

    def occupied_by_friend?(target_position)
      other_piece = board.get(target_position).piece
      other_piece && other_piece.color == piece.color
    end

    def occupied_by_enemy?(target_position)
      other_piece = board.get(target_position).piece
      other_piece && other_piece.color != piece.color
    end
  end
end
