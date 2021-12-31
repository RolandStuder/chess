# frozen_string_literal: true

class Move
  # unlimited horizontal movement for a piece
  class EnPassant < Move
    def position_candidates
      directions = piece.white? ? white_directions : black_directions
      if board.en_passant_target_position && (directions.compact.include? board.en_passant_target_position)
        [board.en_passant_target_position]
      else
        []
      end
    end

    def operations_on_board
      [
        { type: :capture, target: capture_target },
        { type: :move, origin: position, target: target }
      ]
    end

    def white_directions
      [position.up&.left,
       position.up&.right]
    end

    def black_directions
      [position.down&.left,
       position.down&.right]
    end

    def capture_target
      piece.black? ? board.en_passant_target_position.up : board.en_passant_target_position.down
    end
  end
end
