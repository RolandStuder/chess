# frozen_string_literal: true

# King piece to rule them all
class King < Piece
  def move_types
    if black?
      [Move::OneIntoAnyDirection, Move::BlackLeftCastle, Move::BlackRightCastle]
    else
      [Move::OneIntoAnyDirection, Move::WhiteLeftCastle, Move::WhiteRightCastle]
    end
  end

  def to_s
    black? ? "♔" : "♚"
  end
end
