require_relative 'chess'

if ARGV.length.positive?
  Game.from_fen(ARGV.join).play
else
  Game.new.play
end