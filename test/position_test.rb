# frozen_string_literal: true

require "minitest/autorun"
require_relative '../main'

class PositionTest < Minitest::Test
  def test_parse_position_from_string
    assert_nil Position.parse("zz")
    assert_equal  "A", Position.parse("A4").letter
    assert_equal  4, Position.parse("A4").number
  end

  def test_positions_are_comparable
    assert_equal Position.parse("G5"), Position.parse("G5")
    assert_equal [Position.parse("G5")], [Position.parse("G5")]
  end
end
