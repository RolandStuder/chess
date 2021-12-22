# ruby -Ilib:test test/board_test.rb
require "minitest/autorun"
require_relative '../main'

class BoardTest < Minitest::Test
  def test_get_field_from_board
    assert_kind_of Field, Board.new.get("A", "1")
    assert Board.new.get("A", "1").black?
    assert Board.new.get("B", "1").white?
    assert Board.new.get("A", "2").white?
    assert Board.new.get("B", "2").black?
  end
end
