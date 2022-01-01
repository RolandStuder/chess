# frozen_string_literal: true

require "minitest/autorun"
require_relative '../main'

class GameTest < Minitest::Test
  def test_threefold_repetition_draw
    white_player = TestPlayer.new(:white, moves: %w[F3F4 F4F3] * 3)
    black_player = TestPlayer.new(:black, moves: %w[C7C6 C6C7] * 3)
    game = Game.from_fen("1k6/2r5/8/8/8/5R2/8/6K1 w - - 0 1", white_player: white_player, black_player: black_player)
    assert_output(/Draw \(Threefold repetition\)/) { game.play }
  end
end
