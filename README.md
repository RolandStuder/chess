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
* implement promotion
* Implement draw situations
  * stalemate
  * dead positions (might be covered by stalemate)
  * threefold repetition
  * 50 move rule
* maybe refactor operations_on_board, into "move_pieces" and "captures"
* maybe refactor out pawn conditional class to move (position candidates)

## Testing

run `rake test`

## Blockage I had

