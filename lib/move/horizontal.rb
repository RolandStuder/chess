# frozen_string_literal: true

module Move
  # unlimited horizontal movement for a piece
  class Horizontal
    def unhindered_legal_end_positions(position)
      position = Position.parse(position) if position.is_a? String
      letters = ("A".."H").to_a - [position.letter]
      letters.map { |l| Position.new(l, position.number) }
    end
  end
end
