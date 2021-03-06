# frozen_string_literal: true

require "minitest/autorun"
require_relative '../chess'

class BoardTest < Minitest::Test
  def test_get_square_from_board
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

  def test_capture_a_piece
    board = Board.new
    piece = Rook.new(:white)
    other_piece = Piece.new(:black)
    board.place(piece, "A1")
    board.place(other_piece, "A2")

    board.move("A1", "A2")
    assert_equal piece, board.get("A2").piece
  end

  def test_get_black_pieces_from_board
    board = Board.new
    board.place(Rook.new(:white), "A1")
    board.place(Rook.new(:black), "A4")

    assert_equal 1, board.squares_occupied_by(:white).size
    assert(board.squares_occupied_by(:white).all? { |square| square.piece.white? })
  end

  def test_check_for_a_color
    board = Board.from_fen("K1r6/8/8/8/8/8/8/8 w KQkq - 0 1")
    assert board.in_check?(:white)
    assert !board.in_check?(:black)

    board = Board.from_fen("K1R1r4/8/8/8/8/8/8/8 w KQkq - 0 1")
    assert !board.in_check?(:white)
  end

  def test_piece_cannot_move_if_it_creates_check_for_own_color
    board = Board.from_fen("8/8/8/4K3/3R4/2b5/8/8 w - - 0 1")
    assert board.legal_target_positions_for("D4").empty?
  end

  def test_piece_only_allows_moves_that_remove_check
    board = Board.from_fen("8/8/8/4K3/8/2b5/3R4/8 w - - 0 1")
    assert_equal [Position.parse("D4")], board.legal_target_positions_for("D2")
  end

  def test_returns_checkmate
    board = Board.from_fen("8/8/8/4K3/8/2b5/3R4/8 w - - 0 1")
    assert !board.in_checkmate?(:white)

    board = Board.from_fen("8/8/6r1/4K1r1/6q1/2b5/3R4/8 w - - 0 1")
    assert board.in_checkmate?(:white)
  end

  def test_get_move_type
    board = Board.with_setup
    assert Move::Vertical, Move.from_board(board, "C7", "C5")
  end

  def test_stale_mate
    board = Board.from_fen("k7/8/8/8/8/6q1/8/7K w - - 0 1")
    assert board.in_stalemate?(:white)

    board = Board.from_fen("k5qr/8/2n4B/p1P5/P7/8/r7/7K w - - 0 1")
    assert board.in_stalemate?(:white)
  end
end
