# frozen_string_literal: true

# Bishop that can move diagonally
class Bishop < Piece
  def move_types
    [Move::Diagonal]
  end

  def to_s
    black? ? "♗" : "♝"
  end
end
