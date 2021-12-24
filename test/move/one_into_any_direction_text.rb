# frozen_string_literal: true

require "minitest/autorun"

module Move
  class OneIntoAnyDirectionTest < Minitest::Test
    def test_move_right
      board = Board.new
      board.place(Piece.new(:black), "A1")
      move = Move::OneIntoAnyDirection.new(board, "A1")

      assert_includes move.legal_moves, Position.parse("B1")
      assert !move.legal_moves.include?(Position.parse("C1"))
    end
  end
end
