# frozen_string_literal: true

# Rook that can move vertically and horizontally and diagonally
class Pawn < Piece
  def move_types
    if black?
      black_move_types
    else
      white_move_types
    end
  end

  def black_move_types
    [
      Move::OneDown,
      (Move::TwoDown unless moved?),
      Move::DownDiagonalCapture
    ].compact
  end

  def white_move_types
    [
      Move::OneUp,
      (Move::TwoUp unless moved?),
      Move::UpDiagonalCapture
    ].compact
  end
end
