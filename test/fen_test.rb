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
end
