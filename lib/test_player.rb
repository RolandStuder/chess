class TestPlayer < Player
  attr_reader :color

  def initialize(color, moves: [])
    @color = color
    @moves = []
  end

  def prompt_for_move(board)
    @moves.shift || random_move(board)
  end

  def sleep_duration
    0
  end

  def prompt_for_promotion
    "q"
  end

  def random_move(board)
    square = board.squares_occupied_by(color).sample
    target = board.legal_target_positions_for(square.position).sample
    square.position.to_s + target.to_s
  end
end