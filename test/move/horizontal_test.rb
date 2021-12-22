# frozen_string_literal: true

require "minitest/autorun"

module Move
  class HorizontalTest < Minitest::Test
    def test_legal_move_blocked_by_other_piece
      board = Board.new

      move = Move::Horizontal.new
      assert_includes move.legal_moves(board, "C1"), Position.parse("A1")

      board.place(Piece.new, "B1")
      assert !move.legal_moves(board, "C1").include?(Position.parse("A1"))

      assert_includes move.legal_moves(board, "C1"), Position.parse("H1")

      board.place(Piece.new, "F1")
      assert !move.legal_moves(board, "C1").include?(Position.parse("H1"))
    end
  end
end
