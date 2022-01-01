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
    @half_turns = 0
    @turns = 0
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity
  def play
    loop do
      system("clear")
      puts display.board
      puts "You are in Check!" if board.in_check?(@active_color)
      puts "#{@active_color.capitalize} your move"
      print "> "
      input = gets.chomp
      next unless valid_input?(input)
      next unless valid_move?(input)

      @turns += 1 if @active_color == white
      move = board.move(input[0, 2], input[2, 2])

      promote_with_move(move) if move.promotion_available?
      break if checkmate?
      break if stalemate?

      switch_active_color
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity

  private

  def switch_active_color
    @active_color = opponent_color
  end

  def opponent_color
    @active_color == :white ? :black : :white
  end

  def stalemate?
    return false unless board.in_stalemate?(opponent_color)

    puts "Draw (stalemate)"
    true
  end

  def checkmate?
    return false unless board.in_checkmate?(opponent_color)

    puts "#{@active_color} won"
    true
  end

  def valid_move?(input)
    return true if board.valid_move_for?(@active_color, input[0, 2], input[2, 2])

    puts "not a valid move for #{@active_color}"
    sleep 2
    false
  end

  def valid_input?(input)
    return true if Position.parse(input[0, 2]) && Position.parse(input[2, 2])

    puts "not a valid input use format 'a1b2' to perform a move"
    sleep 3
    false
  end

  # rubocop:disable  Metrics/AbcSize, Metrics/MethodLength
  def promote_with_move(move)
    system("clear")
    puts display.board

    square = board.get(move.target)
    color = square.piece.color
    choice = ""
    loop do
      puts "Your pawn gets a promotion, please choose: (Q)ueen, (R)ook, K(N)ight, (B)ishop."
      choice = gets.chomp
      break if choice.size == 1 && "QRNB".include?(choice.upcase)
    end
    choice = color == :black ? choice.downcase : choice.upcase
    square.piece = Piece.from_fen(choice)
  end
  # rubocop:enable  Metrics/AbcSize, Metrics/MethodLength
end
