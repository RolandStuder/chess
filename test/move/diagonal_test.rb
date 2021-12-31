# frozen_string_literal: true

require "minitest/autorun"

class Move
  class DiagonalTest < Minitest::Test
    def test_legal_move_blocked_by_other_piece_to_the_upper_right
      board = Board.new
      board.place(Piece.new(:black), "C1")

      move = Move::Diagonal.new(board, "C1")
      assert_includes move.legal_target_positions, Position.parse("A3")

      board.place(Piece.new(:white), "B2")
      assert !move.legal_target_positions.include?(Position.parse("A1"))
    end
  end
end
