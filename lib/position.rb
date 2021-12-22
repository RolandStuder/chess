class Position
  attr :letter, :number

  def self.parse(string)
    letter = string.strip.chars[0].upcase
    number = string.strip.chars[1].to_i

    return nil unless ("A".."H").include? letter
    return nil unless (1..8).include? number

    new(letter, number)
  end

  def initialize(letter, number)
    @letter = letter
    @number = number.to_i
  end
end