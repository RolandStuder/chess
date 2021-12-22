# ruby -Ilib:test test/board_test.rb
require "minitest/autorun"
require_relative '../main'

class BoardTest < Minitest::Test
  def test_get_field_from_board
    assert Board.new.get(Position.parse("A1")).black?
    assert Board.new.get(Position.parse("B1")).white?
    assert Board.new.get(Position.parse("A2")).white?
    assert Board.new.get(Position.parse("B2")).black?
  end
end
