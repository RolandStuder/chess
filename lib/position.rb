# frozen_string_literal: true

# ValueObject to refer to a field on a board
class Position
  attr :letter, :number

  def self.parse(input)
    return input.map { |pos| Position.parse(pos) } if input.is_a? Array
    return input if input.is_a? Position

    letter = input.strip.chars[0].upcase
    number = input.strip.chars[1].to_i

    return nil unless ("A".."H").include? letter
    return nil unless (1..8).include? number

    new(letter, number)
  end

  def initialize(letter, number)
    @letter = letter
    @number = number.to_i
  end

  # all positions to the left, sorted by closest
  def positions_to_the_left
    index = ("A".."H").find_index(letter)
    ("A".."H").first(index).map { |l| Position.new(l, number) }.reverse
  end

  # all positions to the left, sorted by closest
  def positions_to_the_right
    index = ("A".."H").find_index(letter)
    ("A".."H").last(7 - index).map { |l| Position.new(l, number) }
  end

  def ==(other)
    letter == other.letter && number == other.number
  end

  def ===(other)
    letter == other.letter && number == other.number
  end

  # manhatten distance to other position
  def distance_to(other)
    other = Position.parse(other)
    (number - other.number).abs + (letter.ord - other.letter.ord).abs
  end
end
