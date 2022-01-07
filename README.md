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

## Writing things up

I want to commetn more here, on my thinking, I have some discord posts I made, that could be helpful for that:

---


```ruby
class Knight < Piece
  def move_types
    [Move::Knight]
  end

  def to_s
    black? ? "♘" : "♞"
  end
end
```

So for this to make sense, you should also see an example of the piece class. Here the knight, since it is the simplest.

So early on in Chess, I was thinking.  Well the tricky part is there has to be a thing, that knows the rules around movement. Movement rules depend on the current positions on the board.

I though, well I can always ask the pieces, and pass in the board. But that felt like a lot of logic on the piece. On the other hand, the board can not do all these things, or it will be overburdened.

So there needs to be something like a MoveValidator / MoveEvaluation.

At that point I though, hm, there are different kinds of moves, so that sounds like there are aspects of moves that are relevant for all moves, and some that are only relevant for specific moves.

That made me think, hm, I guess a Move is a thing. And it has it's rules.

So I started implementing my first kind of move Move::Horizontal. And realized, ah ok, a piece just needs to know what kind of moves it is allowed to do. So let us put that on the piece:
Hence the 
```ruby
  def move_types
    [Move::Knight]
  end
```

I was not actually sure, how I would use this on the board. But I realized I need the board anyway. So made it the responsability of the move to see what is allowed. Basically every piece has one or more move types he might be performing, so asking if something is a legal move is:

- looking at a square on the board (origin)
- asking what move_types that piece has
then asking that move_type, given the board, what are legal_end_positions

So, for example for promotion, my logic is this, the board performs the move, and asks everytime if that move makes a promotion available:

```ruby
class Move
  class OneDown < Move
    def position_candidates
      [(position.down unless board.get(position.down).occupied?)].compact
    end

    def promotion_available?
      target&.rank == 1
    end
  end
end
```

So the OneDown move is only available to a black Pawn, therefore I can just ask if the target position of the move is in rank 1
