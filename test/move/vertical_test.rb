# frozen_string_literal: true

require "minitest/autorun"

module Move
  class VerticalTest < Minitest::Test
    def test_move_vertical
      board = Board.new
      board.place(Rook.new(:black), "C1")
      move = Move::Vertical.new(board, "C1")

      assert_includes move.legal_moves, Position.parse("C8")

      board.place(Piece.new(:black), "C2")
      assert !move.legal_moves.include?(Position.parse("C2"))
    end
  end
end
