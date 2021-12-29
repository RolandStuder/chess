# frozen_string_literal: true

module Move
  # unlimited horizontal movement for a piece
  class EnPassant < Base
    def position_candidates
      if board.en_passant_target_position && ([position.down&.left,
                                               position.down&.right].compact.include? board.en_passant_target_position)
        [board.en_passant_target_position]
      else
        []
      end
    end

    def operations_on_board
      [
        { type: :capture, target: board.en_passant_target_position.up },
        { type: :move, origin: position, target: target }
      ]
    end
  end
end
