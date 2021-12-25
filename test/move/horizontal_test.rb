# frozen_string_literal: true

require "minitest/autorun"

module Move
  class HorizontalTest < Minitest::Test
    def test_legal_move_blocked_by_other_piece_to_the_left
      board = Board.new
      board.place(Piece.new(:black), "C1")

      move = Move::Horizontal.new(board, "C1")
      assert_includes move.legal_target_positions, Position.parse("A1")

      board.place(Piece.new(:white), "B1")
      assert !move.legal_target_positions.include?(Position.parse("A1"))
    end

    def test_legal_move_blocked_by_enemy_piece_to_the_right
      board = Board.new
      board.place(Piece.new(:black), "C1")
      move = Move::Horizontal.new(board, "C1")
      board.place(Piece.new(:white), "F1")

      assert_includes move.legal_target_positions, Position.parse("F1")
      assert !move.legal_target_positions.include?(Position.parse("H1"))
    end

    def test_legal_move_blocked_by_own_piece
      board = Board.new
      board.place(Rook.new(:black), "C1")
      board.place(Piece.new(:black), "B1")
      move = Move::Horizontal.new(board, "C1")
      assert !move.legal_target_positions.include?(Position.parse("B1"))
    end
  end
end
