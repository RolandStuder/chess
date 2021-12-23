# frozen_string_literal: true

# Knight can jump around
class Knight < Piece
  def move_types
    [Move::Knight]
  end
end
