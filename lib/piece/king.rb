# frozen_string_literal: true

# King piece to rule them all
class King < Piece
  def move_types
    if black?
      [Move::OneIntoAnyDirection, Move::BlackLeftCastle]
    else
      [Move::OneIntoAnyDirection]
    end
  end
end
