# frozen_string_literal: true

# Rook that can move vertically and horizontally
class Rook < Piece
  def move_types
    [Move::Horizontal, Move::Vertical]
  end

  def to_s
    black? ? "♖" : "♜"
  end
end
