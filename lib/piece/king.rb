# frozen_string_literal: true

# King piece to rule them all
class King < Piece
  def move_types
    [Move::OneIntoAnyDirection]
  end
end
