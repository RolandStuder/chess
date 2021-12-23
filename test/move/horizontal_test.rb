# frozen_string_literal: true

require "minitest/autorun"

module Move
  class HorizontalTest < Minitest::Test
    def test_legal_move_blocked_by_other_piece_to_the_left
      board = Board.new

      move = Move::Horizontal.new(board, "C1")
      assert_includes move.legal_moves, Position.parse("A1")

      board.place(Piece.new, "B1")
      assert !move.legal_moves.include?(Position.parse("A1"))
    end

    def test_legal_move_blocked_by_other_piece_to_the_right
      board = Board.new

      move = Move::Horizontal.new(board, "C1")

      # to the right
      assert_includes move.legal_moves, Position.parse("H1")
      board.place(Piece.new, "F1")
      assert !move.legal_moves.include?(Position.parse("H1"))
    end
  end
end
