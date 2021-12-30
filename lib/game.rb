# frozen_string_literal: true

# running an actual game, containing the main game loop
class Game
  attr_reader :board, :display

  def self.start
    new.play
  end

  def self.from_fen(string)
    board = Board.from_fen(string)
    active_color = string.split[1] == "w" ? :white : :black
    new(board, active_color: active_color).play
  end

  def initialize(board = nil, active_color: :white)
    @board = board || Board.with_setup
    @active_color = active_color
    @display = Display.new(@board)
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength:
  def play
    loop do
      system("clear")
      puts display.board
      puts "You are in Check!" if board.in_check?(@active_color)
      puts "#{@active_color.capitalize} your move"
      print "> "
      input = gets.chomp
      next if valid_move?(input)
      board.move(input[0, 2], input[2, 2])
      break if checkmate?
      break if stalemate?

      switch_active_color
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength:

  private

  def switch_active_color
    @active_color = opponent_color
  end

  def opponent_color
    @active_color == :white ? :black : :white
  end

  def stalemate?
    if board.in_stalemate?(opponent_color)
      system("clear")
      puts "Draw (stalemate)"
      return true
    end
  end

  def checkmate?
    if board.in_checkmate?(opponent_color)
      system("clear")
      puts "#{@active_color} won"
      return true
    end
  end

  def valid_move?(input)
    unless board.valid_move_for?(@active_color, input[0, 2], input[2, 2])
      puts "not a valid move for #{@active_color}"
      sleep 2
      return true
    end
  end
end
