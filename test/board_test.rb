# frozen_string_literal: true

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

  def test_move_a_piece
    board = Board.new
    piece = Rook.new
    board.place(piece, "A1")
    board.move("A1", "A8")

    assert board.get("A1").empty?
    assert_equal piece, board.get("A8").piece
  end

  def test_board_raises_error_on_illegal_move
    board = Board.new
    piece = Rook.new
    board.place(piece, "A1")

    assert_raises { board.move("A1", "B2") }
  end

  def test_capture_a_piece
    board = Board.new
    piece = Rook.new(:white)
    other_piece = Piece.new(:black)
    board.place(piece, "A1")
    board.place(other_piece, "A2")

    board.move("A1", "A2")
    assert_includes board.captured_pieces, other_piece
    assert_equal piece, board.get("A2").piece
  end
end
