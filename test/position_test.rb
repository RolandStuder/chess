# frozen_string_literal: true

require "minitest/autorun"
require_relative '../chess'

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

  def test_positions_diagonal
    assert_equal Position.parse(%w[A4]), Position.parse("B3").positions_up_left
    assert_equal Position.parse(%w[C4 D5 E6 F7 G8]), Position.parse("B3").positions_up_right
    assert_equal Position.parse(%w[A2]), Position.parse("B3").positions_down_left
    assert_equal Position.parse(%w[C2 D1]), Position.parse("B3").positions_down_right
  end
end
