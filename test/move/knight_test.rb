# frozen_string_literal: true

require "minitest/autorun"

module Move
  class KnightTest < Minitest::Test
    def test_knight_move
      board = Board.new
      board.place(::Knight.new(:black), "C1")
      move = Move::Knight.new(board, "C1")

      assert_includes move.legal_moves, Position.parse("D3")

      board.place(Piece.new(:black), "D3")
      assert !move.legal_moves.include?(Position.parse("D3"))
    end
  end
end
