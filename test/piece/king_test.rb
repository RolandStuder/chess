# frozen_string_literal: true

require "minitest/autorun"
require_relative '../../main'
class Piece
  class KingTest < Minitest::Test
    def test_two_kings_dont_blow_up_check_for_in_check
      board = Board.from_fen("k7/8/8/8/8/8/8/K7 w KQkq - 0 1")
      assert_includes board.legal_target_positions_for("A8"), Position.parse("B8")
    end
  end
end
