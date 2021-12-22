# frozen_string_literal: true

# Rook that can move vertically and horizontally
class Rook < Piece
  def move_types
    [Move::Horizontal]
  end
end
