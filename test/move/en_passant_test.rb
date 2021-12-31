# frozen_string_literal: true

require "minitest/autorun"

class Move
  class EnPassantTest < Minitest::Test
    def test_en_passant_square_is_nil_after_normal_move
      board = Board.new
      board.place(Rook.new(:black), "C1")

      board.move("C1", "H1")
      assert_nil board.en_passant_target_position
    end

    def test_en_passant_square_is_set_after_down_move_by_pawn_but_nil_after_further_move
      board = Board.new
      board.place(Pawn.new(:black), "B7")

      board.move("B7", "B5")
      assert_equal Position.parse("B6"), board.en_passant_target_position

      board.move("B5", "B4")
      assert_nil board.en_passant_target_position
    end

    def test_en_passant_is_legal_target_position
      board = Board.from_fen("rnbqkbnr/pppppp1p/8/8/5PpP/4P3/PPPP2P1/RNBQKBNR b KQkq h3 0 4")
      assert_includes board.legal_target_positions_for("G4"), Position.parse("H3")
    end

    def test_en_passant_move_down_captures_passed_pawn
      board = Board.from_fen("rnbqkbnr/pppppp1p/8/8/5PpP/4P3/PPPP2P1/RNBQKBNR b KQkq h3 0 4")
      assert_includes board.legal_target_positions_for("G4"), Position.parse("H3")

      board.move("G4", "H3")
      # pawn moved
      assert_equal Pawn.new(:black), board.get("H3").piece

      # other pawn captured
      assert_includes board.captured_pieces, Pawn.new(:white)
      assert_nil board.get("H4").piece
    end

    def test_en_passant_move_up
      board = Board.from_fen("rnbqkbnr/p2ppppp/8/2pP4/1pP5/4P3/PP3PPP/RNBQKBNR w KQkq c6 0 5")
      assert_includes board.legal_target_positions_for("D5"), Position.parse("C6")
    end
  end
end
