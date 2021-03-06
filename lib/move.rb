# frozen_string_literal: true

# A move contains the logic around what moves are allowed
# This is a base class for all specific moves, like horizontal and en passant
class Move
  attr_reader :board, :position, :piece, :target

  def self.from_board(board, origin, target)
    origin = Position.parse(origin)
    types = board.get(origin).piece.move_types
    move_type = types.find do |type|
      type.new(board, origin).send(:position_candidates).include?(Position.parse(target))
    end || Move
    move_type.new(board, origin, target)
  end

  def initialize(board, position, target = nil)
    @board = board
    @position = Position.parse(position)
    @target = Position.parse(target)
    @piece = board.get(position).piece
    @captures_piece = board.get(capture_target).occupied? if capture_target
  end

  # tells the board what to do after a move
  def piece_displacements
    [
      { origin: position, target: target }
    ]
  end

  # set on initializing, as board may change after
  def captures_piece?
    @captures_piece
  end

  def capture_target
    target
  end

  def legal_target_positions
    positions = position_candidates
    positions -= target_positions_that_are_occupied_by_friend
    positions -= target_positions_that_leave_check_for_own_king
    positions
  end

  # to check for check, an attack move that leaves your own king in check, is still relevant
  def threatening_positions
    positions = position_candidates
    positions -= target_positions_that_are_occupied_by_friend
    positions
  end

  def en_passant_target_positions
    nil
  end

  def promotion_available?
    false
  end

  # only turns that further pawns or are a capture reset the half turn clock
  # this is to draw after 100 half moves, 50 moves
  def resets_half_turn_clock?
    captures_piece?
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
    return false if target_position.nil?

    other_piece = board.get(target_position).piece
    other_piece && other_piece.color != piece.color
  end

  def target_positions_that_are_occupied_by_friend
    position_candidates.compact.select { |target_position| occupied_by_friend?(target_position) }
  end

  def target_positions_that_leave_check_for_own_king
    position_candidates.compact.select do |target_position|
      temp_board = Marshal.load(Marshal.dump(@board))
      temp_board.move(position, target_position)
      temp_board.in_check?(piece.color)
    end
  end
end
