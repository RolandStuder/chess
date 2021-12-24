# frozen_string_literal: true

require "minitest/autorun"
require_relative '../main'

class FENTest < Minitest::Test
  def test_parsing
    fen = FEN.new("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
    fen.to_squares
    binding.irb
  end
end
