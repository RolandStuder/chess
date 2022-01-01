class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def sleep_duration
    2
  end

  def prompt_for_move(_board)
    puts "#{@color.capitalize} your move"
    print "> "
    gets.chomp
  end

  def prompt_for_promotion
    puts "Your pawn gets a promotion, please choose: (Q)ueen, (R)ook, K(N)ight, (B)ishop."
    gets.chomp
  end
end