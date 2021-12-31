# frozen_string_literal: true

# ValueObject to refer to a square on a board
class Position
  COLUMNS = ("A".."H").to_a.freeze
  ROWS = (1..8).to_a.freeze
  @registry = {}

  attr :letter, :number
  alias rank number
  alias file letter

  # we want "A1" to always return the same object, so we can
  # do stuff like subtracting arrays,
  def self.new(letter, number)
    as_string = letter + number.to_s
    return @registry[as_string] if @registry[as_string]

    @registry[as_string] = super
  end

  # rubocop:disable Metrics/CyclomaticComplexity:
  def self.parse(input)
    return nil if input.nil?
    return parse_array(input) if input.is_a? Array
    return input if input.is_a? Position

    letter = input.strip.chars[0]&.upcase
    number = input.strip.chars[1]&.to_i

    return nil unless COLUMNS.include? letter
    return nil unless ROWS.include? number

    new(letter, number)
  end
  # rubocop:enable Metrics/CyclomaticComplexity:

  def to_s
    letter + number.to_s
  end

  def self.parse_array(array)
    array.map { |pos| Position.parse(pos) }
  end

  def initialize(letter, number)
    @letter = letter
    @number = number.to_i
  end

  # all positions to the left, sorted by closest
  def positions_to_the_left
    collect_positions(:left)
  end

  # all positions to the right, sorted by closest
  def positions_to_the_right
    collect_positions(:right)
  end

  # all positions up, sorted by closest
  def positions_upwards
    collect_positions(:up)
  end

  # all positions down, sorted by closest
  def positions_downwards
    collect_positions(:down)
  end

  def positions_up_left
    collect_positions(:up, :left)
  end

  def positions_up_right
    collect_positions(:up, :right)
  end

  def positions_down_left
    collect_positions(:down, :left)
  end

  def positions_down_right
    collect_positions(:down, :right)
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
  def go(*directions)
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

  private

  def column_index
    COLUMNS.find_index(letter)
  end

  def row_index
    ROWS.find_index(number)
  end

  # follow the commands :left, :up, and collects all positions on the baord
  def collect_positions(*commands)
    positions = []
    current_position = self
    while (current_position = current_position.go(*commands))
      positions << current_position
    end
    positions
  end
end
