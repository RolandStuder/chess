# Chess

Implemented in Ruby, the interface is minimal, I was more interested in the general
way of implementing the game logic and rules.

to run the game

* ``bundle install``
* ``ruby main.rb``

You can also start a game from a FEN notation like:

``ruby main.rb "rnbqkbnr/pp1ppppp/8/2p5/4P3/5N2/PPPP1PPP/RNBQKB1R b KQkq - 1 2"``

## TODO / State:

* add 5D blindfolded variant for @timato
* save game state (not done, but would be easy thanks to fen serializer)
* write a bit about the journey and possibly interesting subject
* write about where I think there is room for improvements 
* see, how I can get out of relative requires

There are certainly areas of improvments, but overall I like the design

Note, that I so far haven't done any refactors, just to clean up. I only refactored when I needed
the code to make space for some new requirements.

## Testing

run `rake test`
