# frozen_string_literal: true

# ValueObject to refer to a field on a board
class Position
  COLUMNS = ("A".."H").to_a.freeze
  ROWS = (1..8).to_a.freeze

  attr :letter, :number

  def self.parse(input)
    return input.map { |pos| Position.parse(pos) } if input.is_a? Array
    return input if input.is_a? Position

    letter = input.strip.chars[0].upcase
    number = input.strip.chars[1].to_i

    return nil unless COLUMNS.include? letter
    return nil unless ROWS.include? number

    new(letter, number)
  end

  def initialize(letter, number)
    @letter = letter
    @number = number.to_i
  end

  # all positions to the left, sorted by closest
  def positions_to_the_left
    COLUMNS.first(column_index).map { |l| Position.new(l, number) }.reverse
  end

  # all positions to the right, sorted by closest
  def positions_to_the_right
    COLUMNS.last(7 - column_index).map { |l| Position.new(l, number) }
  end

  # all positions up, sorted by closest
  def positions_upwards
    ((number + 1)..ROWS.last).map { |n| Position.new(letter, n) }
  end

  # all positions down, sorted by closest
  def positions_downwards
    (ROWS.first..(number - 1)).map { |n| Position.new(letter, n) }.reverse
  end

  def positions_up_left
    diagonal_positions(:up, :left)
  end

  def positions_up_right
    diagonal_positions(:up, :right)
  end

  def positions_down_left
    diagonal_positions(:down, :left)
  end

  def positions_down_right
    diagonal_positions(:down, :right)
  end

  def up
    return nil if row_index == 7

    Position.new(letter, ROWS[row_index + 1])
  end

  def down
    return nil if row_index.zero?

    Position.new(letter, ROWS[row_index - 1])
  end

  def left
    return nil if column_index.zero?

    Position.new(COLUMNS[column_index - 1], number)
  end

  def right
    return nil if column_index == 7

    Position.new(COLUMNS[column_index + 1], number)
  end

  # @param directions Array of directions to follow [:up, :left]
  def follow_directions(directions)
    new_position = self
    directions.each do |direction|
      break if new_position.nil?

      new_position = new_position.send(direction)
    end
    new_position
  end

  def ==(other)
    letter == other.letter && number == other.number
  end

  def ===(other)
    letter == other.letter && number == other.number
  end

  private

  def column_index
    COLUMNS.find_index(letter)
  end

  def row_index
    ROWS.find_index(number)
  end

  def diagonal_positions(*commands)
    positions = []
    current_position = self
    while (current_position = current_position.follow_directions(commands))
      positions << current_position
    end
    positions
  end
end
