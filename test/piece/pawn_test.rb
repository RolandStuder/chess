# frozen_string_literal: true

require "minitest/autorun"

class Piece
  class PawnTest < Minitest::Test
    def test_pawn_can_move_two_if_unmoved
      board = Board.new
      board.place(Pawn.new(:black), "A7")
      assert_includes board.legal_target_positions_for("A7"), Position.parse("A5")

      board.move("A7", "A5")
      assert board.get("A5").piece
      assert !board.legal_target_positions_for("A5").include?(Position.parse("A3"))
    end

    def test_black_pawn_can_capture_down_diagonally
      board = Board.from_fen("8/8/2p5/8/8/8/8/8 w - - 0 1")
      assert_equal false, board.legal_target_positions_for("C6").include?(Position.parse("D5"))
      board.place(Pawn.new(:white), "D5")
      assert board.legal_target_positions_for("C6").include?(Position.parse("D5"))

    end
  end
end
