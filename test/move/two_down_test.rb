# frozen_string_literal: true

require "minitest/autorun"

module Move
  class TwoDowTest < Minitest::Test
    def test_move_down
      board = Board.new
      board.place(Piece.new(:black), "A8")
      move = Move::TwoDown.new(board, "A8")
      assert_includes move.legal_target_positions, Position.parse("A6")

      board.place(Piece.new(:black), "A7")
      assert !move.legal_target_positions.include?(Position.parse("A6"))
    end
  end
end
