# frozen_string_literal: true

require "minitest/autorun"
require_relative '../main'

class DisplayTest < Minitest::Test
  def test_show_stuff
    board = Board.with_setup
    # assert_nil Display.new(board).show
  end
end
