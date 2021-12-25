# frozen_string_literal: true

require "minitest/autorun"

class PieceTest < Minitest::Test
  def test_pieces_are_comparable
    assert_equal Piece.new, Piece.new
    assert Board.with_setup.get("A8").piece == Rook.new(:black)
    assert(Board.with_setup.get("A8").piece != Rook.new(:white))
  end
end
