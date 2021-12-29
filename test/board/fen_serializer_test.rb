# frozen_string_literal: true

require "minitest/autorun"

class Board
  class FENSerializerTest < Minitest::Test
    def test_serializes_fresh_board
      board = Board.with_setup
      fen = Board::FENSerializer.from_board(board)
      assert_nil fen.to_s
    end
  end
end
