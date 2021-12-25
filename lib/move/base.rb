# frozen_string_literal: true

module Move
  # unlimited horizontal movement for a piece
  class Base
    attr_reader :board, :position, :piece, :target

    def initialize(board, position, target = nil)
      @board = board
      @position = Position.parse(position)
      @target = Position.parse(target)
      @piece = board.get(position).piece
    end

    def operations_on_board
      [
        { type: :capture, target: target },
        { type: :move, origin: position, target: target }
      ]
    end

    def legal_target_positions
      positions = position_candidates
      positions -= target_positions_that_are_occupied_by_friend
      positions -= target_positions_that_leave_check_for_own_king
      positions
    end

    private

    def legal_target_positions_in_line(positions)
      legals = []
      positions.each do |target_position|
        break if occupied_by_friend?(target_position)

        legals << target_position
        break if occupied_by_enemy?(target_position)
      end
      legals
    end

    def occupied?(target_position)
      board.get(target_position).occupied?
    end

    def occupied_by_friend?(target_position)
      other_piece = board.get(target_position).piece
      other_piece && other_piece.color == piece.color
    end

    def occupied_by_enemy?(target_position)
      other_piece = board.get(target_position).piece
      other_piece && other_piece.color != piece.color
    end

    def target_positions_that_are_occupied_by_friend
      position_candidates.select { |target_position| occupied_by_friend?(target_position) }
    end

    def target_positions_that_leave_check_for_own_king
      position_candidates.select do |target_position|
        temp_board = Marshal.load(Marshal.dump(@board))
        temp_board.move(position, target_position)
        temp_board.in_check?(piece.color)
      end
    end
  end
end
