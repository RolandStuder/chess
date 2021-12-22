# frozen_string_literal: true

# ruby -Ilib:test test/board_test.rb
require "minitest/autorun"
require_relative '../main'

class BoardTest < Minitest::Test
  def test_get_field_from_board
    board = Board.new
    assert board.get("A1").black?
    assert board.get("B1").white?
    assert board.get("A2").white?
    assert board.get("B2").black?
  end

  def test_place_a_piece
    board = Board.new
    piece = Piece.new
    board.place(piece, "A1")

    assert_kind_of Piece, board.get("A1").piece
  end
end
