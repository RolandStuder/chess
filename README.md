# Chess

Implemented in Ruby

## Principles

* Keep public methods to an absolute minimum
* Try to decouple classes as much as possible

## Models

* Game
* Player
* Board
* MoveHistory
* (Move)
* Piece
  * Pawn
  * Rook
  * Bishop
  * Knight
  * King
  * Queen
* Display
* Field
* Position
* (PromptForMove)


## TODO:

* add 5D blindfolded variante for @timato
* Prevent moves, that set King into check
* Create Pawn
* Create move history
* Create Pawn Moves
* Create Kind
* Creat King Moves
* Maybe: Refactor horizontal / vertical into Move::Straight
* I will need to filter the legal moves more, by some rules, like
  * cannot move away if it creates check
  * cannot move away unless prevents existing check situation

## Testing

run `rake test`