class Field
  attr_reader :row, :col
  def initialize(col, row)
    @row = row
    @col = col
  end
end