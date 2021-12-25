# frozen_string_literal: true

require "minitest/autorun"

class Piece
  class RookTest < Minitest::Test
    def test_rook_can_move_horizontally
      board = Board.new
      board.place(Rook.new, "A1")
      assert_includes board.legal_target_positions_for("A1"), Position.parse("H1")
    end
  end
end
