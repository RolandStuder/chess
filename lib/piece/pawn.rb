# frozen_string_literal: true

# Rook that can move vertically and horizontally and diagonally
class Pawn < Piece
  def move_types
    types = []
    if black?
      types << Move::OneDown
      types << Move::TwoDown unless moved?
    else
      types << Move::OneUp
      types << Move::TwoUp unless moved?
    end
    types
  end
end
