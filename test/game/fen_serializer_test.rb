# frozen_string_literal: true

require "minitest/autorun"

class Game
  class FENSerializerTest < Minitest::Test
    def test_serializes_fresh_board
      game = Game.from_fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
      fen = Game::FENSerializer.from_game(game)
      assert_equal "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", fen.to_s
    end
  end
end
