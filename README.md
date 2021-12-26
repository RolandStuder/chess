# Chess

Implemented in Ruby

## Principles

* Keep public methods to an absolute minimum
* Try to decouple classes as much as possible

## TODO:

* prevent moves that do not remove the existing check
* add castling move
* add en passant
* do promotion of pawn
* check for chekmate
* implement display
* implement game
* implement player
* add 5D blindfolded variant for @timato
* Prevent moves, that set King into check
* Create move history
* Implement draw situations
* I will need to filter the legal moves more, by some rules, like
  * cannot move away if it creates check
  * cannot move away unless prevents existing check situation

## Testing

run `rake test`

## Blockage I had

