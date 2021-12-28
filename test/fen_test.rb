# frozen_string_literal: true

require "minitest/autorun"
require_relative '../main'

class FENTest < Minitest::Test
  def test_parsing
    fen = FEN.new("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
    board = fen.to_board
    assert_kind_of Rook, board.get("A8").piece
    assert board.get("A8").piece.black?
  end

  def test_pawn_moved_unless_in_start_rank
    fen = FEN.new("8/7p/p7/8/8/P7/8/8 w KQkq - 0 1")
    board = fen.to_board

    assert board.get("A6").piece.moved?
    assert !board.get("H7").piece.moved?
  end

  def test_castling_right_removed
    fen = FEN.new("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQK2R w Qkq - 0 1")
    board = fen.to_board
    assert !board.legal_target_positions_for("E1").include?(Position.parse("G1"))
  end
end
