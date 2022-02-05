# Chess

Final project for the ruby course of the Odin Project.

## I highly recommend to explore my approach through my commits, rather than just the finished code

I however completed this project after around 2.5 years of professional 
experience as a Ruby on Rails web developer.

To run the game

* `bundle install`
* `ruby main.rb`

You can also start a game from a FEN notation like:

`ruby main.rb "rnbqkbnr/pp1ppppp/8/2p5/4P3/5N2/PPPP1PPP/RNBQKB1R b KQkq - 1 2"`

## "Why did I do this project, when you already got a job as a web dev?"

I had skipped chess back in the day, feeling a bit overconfident in my abilities and I was super eager to jump to Rails.
I felt like I would not learn that much, or at least it was not clear to me what new things I would learn. I was wrong.
Then I started helping out more in the TOP Discord, saw a lot of people with questions about chess
and just got curious: How hard is it actually do write a chess? 
And how easy would it be for me today with my experience?

So I decided to go for it… after some encouragement from Zach… Thx, Zach!

## My goals

- Get a CLI chess working with all the rules
- Keep the code clean and understandable
- Refactor only to make your code extendable

**My goal was NOT**

- to create the perfect OOP example
- refactor until things are perfect.

## Interesting bits

I'll go through my journey and highlight interesting bits…
The links in this section all point to commits of my chess game, that show the concrete code.

**I highly recommend to explore my approach through my commits, rather than looking at the "finished" code**

#### Find the hard part, what moves are legal?

I did not draw up any diagramms, I just tried to think about the problem that felt like the core part / 
the hardest part:
**Figuring out what piece can move where, given the rules for the piece and the situation on the board**

So in my [initial commit](https://github.com/RolandStuder/chess/commit/dc8bf183f215facdeaf97e0bea3f8a4fc70e9d24) I put
down some notes about what classes I probably need. And how to deal with this core problem. From the beginning I was
thinking to maybe have a `MoveValidator`, because neither the board nor the piece felt like the right place to 
put the responsibility of knowing all those rules.


### A note on testing

I am not a big fan of rspec, and prefer minitest which is much less of a DSL. But you should be able to read
MiniTest test cases without an issue. Added Minitest in my 
[second commit](https://github.com/RolandStuder/chess/commit/f7120c2090f142b83a3ea31360eafd69b78b1823).

### Minimal board

As basically everything happens on the board, it felt like this is where I needed to start.

So my [third commit](https://github.com/RolandStuder/chess/commit/bcbe44c94df5d8bd9bdea7b97cbee5fc77246cc2) 
I added a board class, a field class and a test to get a field from the board.

**Note to self** if I comment on every single commit, I will never finish writing this.

### The concept of `Position`

Chess uses notation like `a4`, it was pretty clear, that I would have to pass around positions/coordinate around all
the time. So instead of needing to think, about what `@board.get(3,6)` means I decided to make the Position a thing.
And I was glad I did, it would turn out to spare me a lot of thinking. So I made that I can do either:
`Positions.parse("A4")` or `Position.new("A", 4)`. Interesting thing is maybe also how I made the positions 
[comparable](https://github.com/RolandStuder/chess/commit/4cd608cdec1d13e06cc34d7ea1c90d37d902ff37)

### How to find legal moves, start somewhere

I was not sure with what move to start with, but it felt like a horizontal or vertical move would be the easiest.
(Hint: it isn't). When thinking about it, I saw that I could 
[isolate the rules for a type of move in a class](https://github.com/RolandStuder/chess/commit/d8e12853da057ce410875aa21e8340eaa19ef152).
So I started out with a `Move::Horizontal` class. Writing a test to check if I got the right square for unhindered movements.

I ignored at this point, that there might be occupying pieces, a king in check or anything. I did not even touch the board
for the test, just seeing if I get the right list of positions back.

Then the next steps are actually nicely shown in the commits:
- [feat: block horizontal movement with other pieces](https://github.com/RolandStuder/chess/commit/32a1348628540b19daa6aee761ecbd313c082db4)
- [refactor: block horizontal movement with other pieces](https://github.com/RolandStuder/chess/commit/29f9326c67bc8107de493ca54dcb285453d41657)
- [refactor: initialize moves with board and position](https://github.com/RolandStuder/chess/commit/ad7fb00a6aae0f7d14ca9315365bcc060f750184)
- [feat: horizontal moves should not allow own pieces capturing](https://github.com/RolandStuder/chess/commit/b8521ba5eeb3ece30709b47bf6902fac38a6464a)
- [refactor: dry up legal moves from both horizontal directions](https://github.com/RolandStuder/chess/commit/51a3173100e030986ef0c353621eb1e9e69986c2)

### Putting together pieces and move types

So moves are done by pieces. So a piece should know what kind of moves it is allowed to make:
So on the pieces I put something like:

````ruby
class Rook < Piece
   def move_types
     [Move::Horizontal, Move::Vertical]
   end
 end
````

And I wired things up, so I could get the legal move by accessing the move types form a piece on the board

[feat: get legal moves via move_types from piece for board](https://github.com/RolandStuder/chess/commit/cd0a933908820d84e4eaf0f6f8f3123ce0a6e91e)

Interesting here is to see, that I only added one test, just to see if the principle works.

```ruby
class Piece
   class RookTest < Minitest::Test
     def test_rook_can_move_horizontally
       board = Board.new
       board.place(Rook.new, "A1")
       assert_includes board.legal_moves_for("A1"), Position.parse("H1")
     end
   end
 end
```

### Leveraging the positions class

At first I thought the positions class would just provide me a way to handle the, but I startd to see that I could
use it to 
[give me relative positions to itself](https://github.com/RolandStuder/chess/commit/26f0bffae8982298a2f8476aa8a485eeba611ec2), 
for example all the positions upwards. Like 
`Position.parse("F3").positions_upwards`. This way a horizontal move did not need to know how to generate
positions in one direction itself.

### Generalizing

From there I started to generalize more as I saw that horizontal / vertical and diagonal moves would always be in a line.
The would always be blocked by friendlies and always allow capturing enemies. So I 
[extracted a base class](https://github.com/RolandStuder/chess/commit/e3d57008d2d1b8e22e7e9aec893fde3698e0102f) 
and created methods for `legal_moves_in_line(positions)` and `occupied_by_friend?(target_position)` and 
`occupied_by_enemy?(target_position)`
see [commit](https://github.com/RolandStuder/chess/commit/91d873cce3c4125f9d831c646ba1ae1d4b8317eb)

### Making positions even more useful

When coming to diagonals, I realized, I would be much happier, if I could just find new positions with relative commands.
So the idea was born to allow stuff like `Position.parse("A4).up.left`, that turned out 
[quite nifty](https://github.com/RolandStuder/chess/commit/9c9cd515faefbdadd806eaf50a37bbb640096b7c). For example
see how I 
[set up the knight moves](https://github.com/RolandStuder/chess/commit/fec9f23463f93fc26a45c647ac06bab8cb60fd90#diff-a02fc73ff19e80b87c7d17a7adabc6042c97096832076d6965aee4aef2a0920c):

````ruby
module Move
   # knight moves in ls
   class Knight < Base
     def legal_moves
       positions = directions.map do |direction|
         position.go(*direction)
       end
       without_illegal_moves(positions.compact)
     end

     private

     def directions
       [
         %i[up up right],
         %i[right right up],
         %i[right right down],
         %i[down down right],
         %i[down down left],
         %i[left left down],
         %i[left left up],
         %i[up up left]
       ]
     end
   end
 end
````

### Profit of abstraction

At this point I had all straight moves, so
[getting the Queen to work felt almost like cheating](https://github.com/RolandStuder/chess/commit/de20a8df2e97f0a5d6cb300a692302aec2b1ea4d#diff-750d4599acc5e71b17c2a0fbd0388e2711ca0a593ead1eb318d536ca8aeec54d)
(please ignore that at this point the Queen was a Bishop :-D )

### The pawns rise up

By the time I got to the pawns, the pattern with the move types was well established,, and 
I was able to 
[conditionally insert move types](https://github.com/RolandStuder/chess/commit/6fb43739e09df53171ca5f71523b9afaa517e5a6#diff-8a4fcaac642333026d9940a12b0a55f80676e61f342d5af18067670cb2118dae) 
`Move::OneDown` and `Move::OneUp` depending on the color

Adding the double move I added the `:moved`
[attribute to the piece class](https://github.com/RolandStuder/chess/commit/f6d854b04f78506554bf370691116975112490a0). 
This felt right, since I knew I would
also need something like that for castling.

### Things get more complex

Until now, I basically only created boards with one single piece on it, sometimes two, to check if one was blocking
the other. But my test only ever had the minimum. To create more complex situation, I read about the 
[FEN Notation](https://en.wikipedia.org/wiki/Forsyth–Edwards_Notation) and 
[got started on that](https://github.com/RolandStuder/chess/commit/c2dbb3e63cb86584aa7367b2df4754c36086cf22) to be able
to create new boards with interesting situations easily, like:
`Board.from_fen("rnbqkbnr/pppppp1p/8/8/5PpP/4P3/PPPP2P1/RNBQKBNR b KQkq h3 0 4")`

### Starting with check stuff

Now I was ready to get gritty and start seeing if I can 
[check for check](https://github.com/RolandStuder/chess/commit/ffdd36d082ac81039a7e0d4d29ec4e0eb54ac1e0#diff-9ed8e0e84a68fbd6192bf0a3f8a029cb7c5f6e8b2effc13e395fb1fd60268173R55)

Basically going through all the squares occupied by one color and checking all their legal moves, and if any included
the king, you got a check.

I decided to go for checking checks and stuff like this, before adding the complex special moves. It felt easier to tackle
this first, can't really say why.

### Gaining more clarity on what things mean/are

The next few commits are a bit less straightforward in their purpose. But I saw I had some stuff names wrongly and it
became confusing, I was asking move types for :legal_moves, but actually 
[received positions back](https://github.com/RolandStuder/chess/commit/39d9f3fe2bc82d6e90333c6102f39bf60fe6c7b3). 
But more importantly some of those positions where not actually legal ones, because they might
[attack a friendly piece](https://github.com/RolandStuder/chess/commit/600c79f266c086eb0d1aa3c0677b62f9f8e293c7), 
or
[they might put the king in check](https://github.com/RolandStuder/chess/commit/1ae7d43810ba455d4580520bce7bd15455dd0ed4).

So the interesting thing now I was able to have a nice method on the base move class, called `legal_target_positions`
that took the position candidates, that then removed the illegal moves:

````ruby
def legal_target_positions
   positions = position_candidates
   positions -= target_positions_that_are_occupied_by_friend(positions)
   positions -= target_positions_that_create_check_for_own_king(positions)
   positions
 end
````
here is the [commit](https://github.com/RolandStuder/chess/commit/36a31c4bd62afb1b0187ab8a2d5c2c923ad53a4e)

btw: this was not as smooth as I thought, turns out `array - other_array` doesn't remove items by comparing
with `==` but actually checks if they are the sae object, so I had to be a bit creative and 
[make sure](https://github.com/RolandStuder/chess/commit/2b54613aa9c6b32b8593a6f5e11e4ca9ff50040d)
that `Position.new("A", 3)` would always return the same object.

### Refactoring to make special moves possible

So far all the move types I had implemented, did exactly one thing, they moved the piece to another position, and
if the squre was occupied by an enemy, it would capture that piece. Thinking about `En passant` and `castling`, I saw
that these things were no longer true. So I saw, that I need to refactor in a way that I would be able to ask the
move what it changes on the board.

So my `board.move` method needed to 
[ask the move type what operation to perform](https://github.com/RolandStuder/chess/commit/05864e08cacb81f2b67fc5dfb61d75baadf7b03a#diff-8511bffe423d1243210f5b58d8d7746501571635e2d326f01e17bc95777c0b01R15)

And moves could then return operations to the board:

```ruby
def operations_on_board
   [
     { type: :capture, target: target },
     { type: :move, origin: position, target: target }
   ]
 end
```

It was a nice abstraction. I was also considering creating an `Operation` class that would then perform actions
on the board. Which would have been even a nicer abstraction, but later felt like overkill. I would much later 
[simplify this and only ask the move, how to place pieces, and which square to capture](https://github.com/RolandStuder/chess/commit/f98fd303f62f3245ba6891b3c67deebe59937b3d)

### Things start to break

So far things had gone pretty smooth, but suddenly I started to get endless loops. The test that provoked this
was quickly identified, but it took me some time to realize that for the first time I had two kings on the board :-)

This was actually the one time, I felt quite stuck. It took me like two days if thinking until I realized what the
problem was: **Threatening a king is not necessarily a legal move!** A rook puts another king in Check even if
such a move would leave your own king in check.

I literally realized this mistake in the shower… :-)

[And here came the fix](https://github.com/RolandStuder/chess/commit/2fc7c371f7768875ef6930c0fedeaa8cfa7859a6)

### Castling: Subclassing

Castling moves felt quite unique. So I decided to implement really just one version of it at first. And tried to think
what was common between castling moves and what was different:

- Common: King and Rook cannot have moved, squares in between are not threatened, there are not blocking pieces in between
- Different: Position of King, and Rook, Target positions of King and Rook.

So I created a `Move::Castle` class for the common behavior and `Move::BlackLeftCastle` to hold the different position.
Probably this subclassing was a bit of an overkill, but honestly I somehow couldn't think through he conditionals needed.
[So if subclassing here, allows me to think less, then I'll take it](https://github.com/RolandStuder/chess/commit/d7c25476020aaa9b879017ea2a777347b5cbea89).

### En passant

After castling en passant felt easy. As the FEN notation contains the en passant target square, it felt like it would
be easiset to just store that one on the board, and let a potential move check against that.

[Implementation of en passant](https://github.com/RolandStuder/chess/commit/4a5cb5d17d8aaf05138ff077921a116edce3ffb2)

Again I just did one direction to keep it simple, and only 
[then did the en passant for the other color](https://github.com/RolandStuder/chess/commit/eedbb8eb3268c14fcdf3e1e8d28a04d66f6238eb).

### Where is the board display? The game? Checkmate? Stalemate?

So until that point, I had not seen a single string representation of my board, it felt like it would be 
* [nice to see something at this point](https://github.com/RolandStuder/chess/commit/586e5b3c6a4f0f8eb81ec0bb59f8bf79bd500a2c).
* and [a game loop](https://github.com/RolandStuder/chess/commit/d21c6b0f3ab7ebb9d559e93760e38bc89565132d)
* checks for [checkmate / stalemate](https://github.com/RolandStuder/chess/commit/8399eb0747b1ab157202fdd518fd43e17a65c613)
* and [promotion](https://github.com/RolandStuder/chess/commit/7f9e7f029e4bb9340b070ef63f011b131167d485)

### Half turn clock?

[To determine whether to reset the half turn clock](https://github.com/RolandStuder/chess/commit/09a046a1440fc1db4ccee70a6baa218cc5c656cf),
I again relied on the move classes, since only capturing moves
or moves from pawn do reset it. So every move class got a `:resets_half_turn_clock?` method.

### Simulating situation for the special draw situations

So far my tests never really did more than one move. To simulate the threefold repetition and so one I needed a way
to run games. So I decided to make a `TestPlayer` 
[class that would just make moves that we pass to it in an Array](https://github.com/RolandStuder/chess/commit/c6878fac0c774bd545c8341ffb1cf165d1be8551#diff-e27d0aaf6555db4532388803effb11e9aee6fad7e62d85d0e1f14b752760bc9b).

You can see me getting lazy: I did not write a test for the threefold repetition, 
[just ran a quick automated game in my main file](https://github.com/RolandStuder/chess/commit/47aae49371713c640013b2c7aa62607a2f7915d4#diff-8c2db00221aa4d66a91598201c26bb6b695ccd79084d53d9783d74f615dba898).

### Done

I did not polish the game at all, I wanted to get the rules right, but did not care much about saving state and
nice visualization others do a much better job with that.

The only neat unnecessary thing I did was: To make it possible to 
[start a game from the command line based on a FEN code](https://github.com/RolandStuder/chess/commit/1396e1a11e496e219a2de23b361456abaefe4407).

`ruby main.rb "rnbqkbnr/pp1ppppp/8/2p5/4P3/5N2/PPPP1PPP/RNBQKB1R b KQkq - 1 2"`

## Reflections

* It was a great experience.
* I was really happy how I was able to continuously refactor with confidence thanks to my tests.
* My tests never actually covered much of the methods on the `Move` classes, it just was simulation positions. But that
was actually mostly beneficial, since I could refactor wildly on the move classes without having to touch the tests.
* I was able to consistently move forward, looking through the commit history 1 month after finishing, the commits
  tell a story, without much back and forth
* It was hugely beneficial to abstract the `Move::Whatever` from the start. It felt like the right abstraction from the
  start and more powerful, than having move logic on the `Piece` classes. 
* I love how easy it would be to add a new Piece with some new moves like:

```ruby
# something like
class Magician < Piece
  def move_types
    [Move::Diagonal, Move::Horizontal, Move::Teleport]
  end
end

class Move::Teleport
  def candidate_positions
    Position.all_possible
  end
end
```

* I was only really stuck once, before realizing legal_target_positions, and threatening_positions were not the same, but 
  showering helped :-)

Also I found a deep respect for anyone who completed Chess, it truly is an achievement! Don't skip it!

## Things that could be nicer

- There are definitely some more things I could have extracted around some rules, and checks for check / checkmate and similar things
  but my classes felt manageable so it was ok, also the goal was not to create the perfect example (which is a matter of taste anyway)
- The part I like the least is, that I needed to find the `Class` in 
  [my factory method](https://github.com/RolandStuder/chess/blob/57ea6b0b16df40e471747e96b1f7b6ee5addbf2a/lib/move.rb#L8) 
  I only recently realized, I should have returned move objects instead of just target positions, when asking a square/piece
  for what is possible from that position.
