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
  end
end
