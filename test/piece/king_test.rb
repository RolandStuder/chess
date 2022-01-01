# frozen_string_literal: true

require "minitest/autorun"
class Piece
  class KingTest < Minitest::Test
    def test_two_kings_dont_blow_up_check_for_in_check
      board = Board.from_fen("k7/8/8/8/8/8/8/K7 w - - 0 1")
      assert_includes board.legal_target_positions_for("A8"), Position.parse("B8")
    end

    def test_black_king_can_castles
      board = Board.from_fen("r3kbnr/8/8/8/8/8/8/K7 w KQkq - 0 1")
      assert_kind_of King, board.get("E8").piece
      assert_includes board.legal_target_positions_for("E8"), Position.parse("C8")
      board.move("E8", "C8")
      assert_equal Rook.new(:black), board.get("D8").piece
      assert_equal King.new(:black), board.get("C8").piece
    end

    def test_king_cannot_castle_if_fields_are_threatened
      board = Board.from_fen("r3kbnr/p3pppp/8/8/8/8/PQ2PPPP/3RKBNR w Kkq - 0 1")
      assert !board.legal_target_positions_for("E8").include?(Position.parse("B8"))
    end

    def test_white_right_hand_castle
      board = Board.from_fen("8/8/8/8/8/8/8/R3K2R w KQkq - 0 1")
      assert board.legal_target_positions_for("E1").include?(Position.parse("G1"))
      board.move("E1", "G1")

      assert_equal Rook.new(:white), board.get("F1").piece
      assert_equal King.new(:white), board.get("G1").piece
    end

    def test_white_left_hand_castle
      board = Board.from_fen("8/8/8/8/8/8/8/R3K2R w KQkq - 0 1")
      assert board.legal_target_positions_for("E1").include?(Position.parse("C1"))
      board.move("E1", "C1")

      assert_equal Rook.new(:white), board.get("D1").piece
      assert_equal King.new(:white), board.get("C1").piece
    end

    def test_black_right_hand_castle
      board = Board.from_fen("r3k2r/8/8/8/8/8/8/8 w KQkq - 0 1")
      assert board.legal_target_positions_for("E8").include?(Position.parse("G8"))
      board.move("E8", "G8")

      assert_equal Rook.new(:black), board.get("F8").piece
      assert_equal King.new(:black), board.get("G8").piece
    end
  end
end
