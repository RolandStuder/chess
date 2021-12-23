# frozen_string_literal: true

module Move
  # unlimited horizontal movement for a piece
  class Horizontal
    attr_reader :board, :position, :piece

    def initialize(board, position)
      @board = board
      @position = Position.parse(position)
      @piece = board.get(position).piece
    end

    def legal_moves
      legal_left_moves + legal_right_moves
    end

    private

    def legal_left_moves
      legals = []
      position.positions_to_the_left.each do |to_the_left|
        other_piece = board.get(to_the_left).piece
        break if other_piece && other_piece.color == piece.color
        legals << to_the_left
        break if other_piece && other_piece.color != piece.color
      end
      legals
    end

    def legal_right_moves
      legals = []
      position.positions_to_the_right.map do |to_the_right|
        other_piece = board.get(to_the_right).piece
        break if other_piece && other_piece.color == piece.color
        legals << to_the_right
        break if other_piece && other_piece.color != piece.color
      end
      legals
    end
  end
end
