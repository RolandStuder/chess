# frozen_string_literal: true

# Rook that can move vertically and horizontally and diagonally
class Bishop < Piece
  def move_types
    [Move::Diagonal, Move::Horizontal, Move::Vertical]
  end
end
