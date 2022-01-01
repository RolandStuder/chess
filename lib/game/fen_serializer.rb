# frozen_string_literal: true

class Game
  # converts a board to a FEN code, will need to be extended to work for games
  class FENSerializer
    attr_reader :board

    def self.from_game(game)
      fen = new(game)
      fen.to_s
    end

    def initialize(game)
      @game = game
      @board = game.board
    end

    def to_s
      [
        ranks,
        current_player, # must come from a game
        castling_rights,
        en_passant_target_square,
        @game.half_turns, # must come from a game
        @game.turn # must come from a game
      ].join(" ")
    end

    def to_threefold_repetition_digest
      ranks + current_player + castling_rights + en_passant_target_square.to_s
    end

    private

    def current_player
      @game.current_player.color.to_s.chars.first
    end

    def ranks
      @board.squares.each_slice(8).to_a.map do |file|
        file_of_squares_to_fen(file)
      end.reverse.join("/")
    end

    # rubocop:disable Metrics/MethodLength
    def file_of_squares_to_fen(file)
      result = ""
      file.each do |square|
        if square.piece
          result += square.piece.to_fen
        elsif result.chars.last.to_i.positive?
          result[-1] = (result[-1].to_i + 1).to_s
        else
          result += "1"
        end
      end
      result
    end
    # rubocop:enable Metrics/MethodLength

    def castling_rights
      rights = []
      rights << "K" if not_moved_at("H8", "E8")
      rights << "Q" if not_moved_at("A8", "E8")
      rights << "k" if not_moved_at("H1", "E1")
      rights << "q" if not_moved_at("A1", "E1")
      rights.empty? ? "-" : rights.join
    end

    def not_moved_at(*positions)
      positions.each do |position|
        board.get(position).piece && !board.get(position).piece.moved?
      end
    end

    def en_passant_target_square
      board.en_passant_target_position || "-"
    end

    def square_to_fen(square); end
  end
end
