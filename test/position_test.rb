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

  def test_positions_to_the_left
    assert_equal Position.parse(%w[B4 A4]), Position.parse("C4").positions_to_the_left
  end

  def test_positions_to_the_right
    assert_equal Position.parse(%w[G4 H4]), Position.parse("F4").positions_to_the_right
  end

  def test_positions_upwards
    assert_equal Position.parse(%w[G7 G8]), Position.parse("G6").positions_upwards
  end

  def test_positions_downwards
    assert_equal Position.parse(%w[G2 G1]), Position.parse("G3").positions_downwards
  end
end
