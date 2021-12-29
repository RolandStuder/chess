# Chess

Implemented in Ruby

## Principles

* Keep public methods to an absolute minimum
* Try to decouple classes as much as possible

## TODO:

* implement display
* implement game
* implement player
* add 5D blindfolded variant for @timato
* implement promotion (first situation that needs an input)
* Implement draw situations
  * threefold repetition, this actually needs the game class
  * 50 move rule, this needs the game class
* maybe refactor operations_on_board, into "move_pieces" and "captures"
* maybe refactor out pawn conditional class to move (position candidates)
* maybe refactor out how board is manipultated from moves
* maybe extract Checks for check and so on

## Testing

run `rake test`

## Blockage I had

