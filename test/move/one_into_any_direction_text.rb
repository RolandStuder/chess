# frozen_string_literal: true

require "minitest/autorun"

class Move
  class OneIntoAnyDirectionTest < Minitest::Test
    def test_move_right
      board = Board.new
      board.place(Piece.new(:black), "A1")
      move = Move::OneIntoAnyDirection.new(board, "A1")

      assert_includes move.legal_target_positions, Position.parse("B1")
      assert !move.legal_target_positions.include?(Position.parse("C1"))
    end
  end
end
