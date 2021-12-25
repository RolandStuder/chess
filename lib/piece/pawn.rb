# frozen_string_literal: true

# Rook that can move vertically and horizontally and diagonally
class Pawn < Piece
  def move_types
    types = []
    if black?
      types << Move::OneDown
      types << Move::TwoDown unless moved?
      types << Move::DownDiagonalCapture
    else
      types << Move::OneUp
      types << Move::TwoUp unless moved?
      types << Move::UpDiagonalCapture
    end
    types
  end
end
