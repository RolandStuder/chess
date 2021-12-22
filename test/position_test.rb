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

  def test_distance_to_other_position
    assert_equal 2, Position.parse("B2").distance_to("A1")
    assert_equal 12, Position.parse("B2").distance_to("H8")
  end

  def test_positions_to_the_left
    assert_equal Position.parse(["B4", "A4"]), Position.parse("C4").positions_to_the_left
  end

  def test_positions_to_the_right
    assert_equal Position.parse(["G4", "H4"]), Position.parse("F4").positions_to_the_right
  end
end
