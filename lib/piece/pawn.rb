# frozen_string_literal: true

# Rook that can move vertically and horizontally and diagonally
class Pawn < Piece
  def move_types
    if black?
      [Move::OneDown]
    else
      [Move::OneUp]
    end
  end
end
