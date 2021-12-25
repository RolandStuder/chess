# frozen_string_literal: true

require "minitest/autorun"

class PieceTest < Minitest::Test
  def test_pieces_are_comparable
    assert(Piece.new == Piece.new)
    assert !(Piece.new != Piece.new)
    assert Board.with_setup.get("A8").piece == Rook.new(:black)
    assert (Board.with_setup.get("A8").piece != Rook.new(:white))
  end
end
