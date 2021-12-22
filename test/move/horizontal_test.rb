# frozen_string_literal: true

require "minitest/autorun"

module Move
  class HorizontalTest < Minitest::Test
    def test_returns_unhindered_positions
      move = Move::Horizontal.new

      legal_end_positions = %w[A3 B3 C3 E3 F3 G3 H3].map { |p| Position.parse(p) } # without D4
      assert_equal legal_end_positions, move.unhindered_legal_end_positions("D3")
    end
  end
end
