# frozen_string_literal: true

require_relative 'lib/square'
require_relative 'lib/fen'
require_relative 'lib/move'
require_relative 'lib/board'
require_relative 'lib/game/fen_serializer'
require_relative 'lib/position'
require_relative 'lib/display'
require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/test_player'

require_relative 'lib/piece'
require_relative 'lib/piece/rook'
require_relative 'lib/piece/bishop'
require_relative 'lib/piece/queen'
require_relative 'lib/piece/knight'
require_relative 'lib/piece/pawn'
require_relative 'lib/piece/king'

require_relative 'lib/move/horizontal'
require_relative 'lib/move/vertical'
require_relative 'lib/move/diagonal'
require_relative 'lib/move/castle'
require_relative 'lib/move/en_passant'
require_relative 'lib/move/black_left_castle'
require_relative 'lib/move/black_right_castle'
require_relative 'lib/move/white_left_castle'
require_relative 'lib/move/white_right_castle'
require_relative 'lib/move/down_diagonal_capture'
require_relative 'lib/move/up_diagonal_capture'
require_relative 'lib/move/knight'
require_relative 'lib/move/one_into_any_direction'
require_relative 'lib/move/one_down'
require_relative 'lib/move/one_up'
require_relative 'lib/move/two_down'
require_relative 'lib/move/two_up'

# Game.from_fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
# Game.from_fen("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")

