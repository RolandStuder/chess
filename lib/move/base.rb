# frozen_string_literal: true

module Move
  # unlimited horizontal movement for a piece
  class Base
    attr_reader :board, :position, :piece

    def initialize(board, position)
      @board = board
      @position = Position.parse(position)
      @piece = board.get(position).piece
    end

    private

    def legal_moves_in_line(positions)
      legals = []
      positions.each do |target_position|
        break if occupied_by_friend?(target_position)

        legals << target_position
        break if occupied_by_enemy?(target_position)
      end
      legals
    end

    def occupied?(target_position)
      board.get(target_position).piece
    end

    def occupied_by_friend?(target_position)
      other_piece = board.get(target_position).piece
      other_piece && other_piece.color == piece.color
    end

    def occupied_by_enemy?(target_position)
      other_piece = board.get(target_position).piece
      other_piece && other_piece.color != piece.color
    end

    def without_illegal_moves(moves)
      moves.reject { |target_position| occupied_by_friend?(target_position) }
    end
  end
end
