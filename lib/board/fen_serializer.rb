# frozen_string_literal: true

class Board
  # converts a board to a FEN code, will need to be extended to work for games
  class FENSerializer
    attr_reader :board

    def self.from_board(board)
      fen = new(board)
      fen.to_s
    end

    def initialize(board)
      @board = board
    end

    def to_s
      [
        ranks,
        "w", # must come from a game
        castling_rights,
        en_passant_target_square,
        "0", # must come from a game
        "1" # must come from a game
      ].join(" ")
    end

    private

    def ranks
      @board.squares.each_slice(8).to_a.map do |file|
        file.map do |square|
          square.piece ? square.piece.to_fen : 1
        end.chunk do |s|
          s.is_a? Integer
        end.map do |is_number, array|
          is_number ? array.sum : array
        end.flatten.join
      end.join("/")
    end

    def castling_rights
      rights = []
      rights << "K" if not_moved_at("H8") && not_moved_at("E8")
      rights << "Q" if not_moved_at("A8") && not_moved_at("E8")
      rights << "k" if not_moved_at("H1") && not_moved_at("E8")
      rights << "q" if not_moved_at("A1") && not_moved_at("E8")
      rights.empty? ? "-" : rights.join
    end

    def not_moved_at(position)
      board.get(position).piece && !board.get(position).piece.moved?
    end

    def en_passant_target_square
      board.en_passant_target_position || "-"
    end
  end
end
