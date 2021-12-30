# frozen_string_literal: true

# running an actual game, containing the main game loop
class Game
  attr_reader :board, :display

  def self.start
    new.play
  end

  def initialize
    @board = Board.with_setup
    @active_color = :white
    @display = Display.new(@board)
  end

  def play
    loop do
      system("clear")
      puts display.board
      puts "#{@active_color.capitalize} your move"
      print "> "
      input = gets.chomp
      board.move(input[0, 2], input[2, 2])
      switch_active_color
    end
  end

  private

  def switch_active_color
    @active_color = (@active_color == :white ? :black : :white)
  end
end
