# frozen_string_literal: true

# ruby -Ilib:test test/board_test.rb
require "minitest/autorun"
require_relative '../main'

class PositionTest < Minitest::Test
  def test_parse_position_from_string
    assert_nil Position.parse("zz")
    assert_equal  "A", Position.parse("A4").letter
    assert_equal  4, Position.parse("A4").number
  end
end
