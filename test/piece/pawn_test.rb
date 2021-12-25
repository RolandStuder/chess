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
  end
end
