# ruby -Ilib:test test/board_test.rb
require "minitest/autorun"
require_relative '../main'

class BoardTest < Minitest::Test
  def test_get_field_from_board
    assert_kind_of Field, Board.new.get("A", "1")
  end
end
