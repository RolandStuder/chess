# frozen_string_literal: true

# running an actual game, containing the main game loop
class Game
  attr_reader :board, :display, :current_player, :half_turns, :turn

  def self.start
    new.play
  end

  def self.from_fen(string, **options)
    board = Board.from_fen(string)
    active_color = string.split[1] == "w" ? :white : :black
    new(board, active_color: active_color, half_turns: string.split[4].to_i, turn: string.split[5].to_i, **options)
  end

  # rubocop:disable Metrics/ParameterLists
  def initialize(board = nil, active_color: :white, white_player: nil, black_player: nil, half_turns: 0, turn: 1)
    @board = board || Board.with_setup
    @active_color = active_color
    @display = Display.new(@board)
    @half_turns = half_turns
    @turn = turn
    @white_player = white_player || Player.new(:white)
    @black_player = black_player || Player.new(:black)
    @repetitions_history = Hash.new(0)
    @current_player = (active_color == :white ? @white_player : @black_player)
  end
  # rubocop:enable Metrics/ParameterLists

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def play
    loop do
      system("clear")
      puts display.board
      puts "You are in Check!" if board.in_check?(current_player.color)
      input = current_player.prompt_for_move(board)
      next unless valid_input?(input)
      next unless valid_move?(input)

      move = board.move(input[0, 2], input[2, 2])

      @turn += 1 if current_player.color == :white
      @half_turns += 1
      @half_turns = 0 if move.resets_half_turn_clock?

      promote_with_move(move) if move.promotion_available?

      break if checkmate?
      break if draw?

      switch_current_player
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def threefold_repetition_digest
    Game::FENSerializer.new(self).to_threefold_repetition_digest
  end

  private

  def switch_current_player
    @current_player = opponent_player
  end

  def opponent_player
    @current_player.color == :white ? @black_player : @white_player
  end

  def draw?
    stalemate? || fifty_turns_passed? || threefold_repetition?
  end

  def stalemate?
    return false unless board.in_stalemate?(opponent_player.color)

    puts "Draw (stalemate)"
    true
  end

  def fifty_turns_passed?
    return false unless @half_turns >= 100

    puts "Draw (50 turns without capture or pawn advancement)"
    true
  end

  def threefold_repetition?
    @repetitions_history[threefold_repetition_digest] += 1
    return false unless @repetitions_history.values.any? { |count| count >= 3 }

    puts "Draw (Threefold repetition)"
    true
  end

  def checkmate?
    return false unless board.in_checkmate?(opponent_player.color)

    puts "#{@active_color} won"
    true
  end

  def valid_move?(input)
    return true if board.valid_move_for?(current_player.color, input[0, 2], input[2, 2])

    puts "not a valid move for #{current_player.color}"
    sleep current_player.sleep_duration
    false
  end

  def valid_input?(input)
    return true if Position.parse(input[0, 2]) && Position.parse(input[2, 2])

    puts "not a valid input use format 'a1b2' to perform a move"
    sleep current_player.sleep_duration
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
      choice = current_player.prompt_for_promotion
      break if choice.size == 1 && "QRNB".include?(choice.upcase)
    end
    choice = color == :black ? choice.downcase : choice.upcase
    square.piece = Piece.from_fen(choice)
  end
  # rubocop:enable  Metrics/AbcSize, Metrics/MethodLength
end
