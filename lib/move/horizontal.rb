# frozen_string_literal: true

module Move
  # unlimited horizontal movement for a piece
  class Horizontal
    def legal_moves(board, position)
      position = Position.parse(position)

      legal_left_moves(board, position) + legal_right_moves(board, position)
    end

    private

    def legal_left_moves(board, position)
      legals = []
      position.positions_to_the_left.each do |to_the_left|
        legals << to_the_left
        break if board.get(to_the_left).piece
      end
      legals
    end

    def legal_right_moves(board, position)
      legals = []
      position.positions_to_the_right.map do |to_the_right|
        legals << to_the_right
        break if board.get(to_the_right).piece
      end
      legals
    end
  end
end
