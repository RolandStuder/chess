# frozen_string_literal: true

require "minitest/autorun"
require_relative '../../main'
class Piece
  class KingTest < Minitest::Test
    def test_two_kings_dont_blow_up_check_for_in_check
      board = Board.from_fen("k7/8/8/8/8/8/8/K7 w KQkq - 0 1")
      assert_includes board.legal_target_positions_for("A8"), Position.parse("B8")
    end

    def test_black_king_can_castles
      board = Board.from_fen("r3kbnr/8/8/8/8/8/8/K7 w KQkq - 0 1")
      assert_kind_of King, board.get("E8").piece
      assert_includes board.legal_target_positions_for("E8"), Position.parse("B8")
      board.move("E8", "B8")
      assert_equal Rook.new(:black), board.get("C8").piece
      assert_equal King.new(:black), board.get("B8").piece
    end

    def test_king_cannot_castle_if_fields_are_threatened
      board = Board.from_fen("r3kbnr/p3pppp/8/8/8/8/PQ2PPPP/3RKBNR w Kkq - 0 1")
      assert !board.legal_target_positions_for("E8").include?(Position.parse("B8"))
    end
  end
end
