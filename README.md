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
* (Reserve) for pieces that are out

## How to keep position

* On Board with "coordinates" for example A1:Pawn?
* On Piece Pawn.position? (so a name for a position)

But the question really is, how decoupled can we have the board from the piece, to determine legal moves
a piece has to know the board, there is now way around that. But what I think in terms of messages, what is more appropriate

````ruby
board.legal_move?("A1", "A2")
piece.legal_move?("A2")
````

You can advocate for both, so let us thing about the sequence:

* Prompt a player for move, to apply, we get 2 positions
* Determine piece on position
* Determine if the move is a legal one, depending on the board and the piece

So it might be it is a concern of neither, and might be a concern of a MoveValidator, that just is responsible for that.
````ruby
MoveValidator.new(move, board).valid?
````

But this might also be premature extraction. Let us see, where it leads us. Actually this might be exciting, and
we might have a MoveValidator.for(move, board), that has different class as per Piece the move is for,
like (`Pawn::MoveValidator`)

Ok, but let's get out of analysis and just play around a bit, to get a sense of the Board API

## Board API

````ruby
print
legal_move?(a,b)
move(a,b)
checkmate?
````

## Piece API
````ruby
position
color
legal_moves
````

## Questions

- Should Move::Horizontal actually be a Class or a Module, I can instantiate moves from a position, I guess
  so the position and board can be referenced in an instance. 

## TODO:

* add 5D blindfolded variante for @timato